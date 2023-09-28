import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:visio/constant/constant_builder.dart';

class ScanController extends GetxController{
  late CameraController cameraController;
  late List<CameraDescription> cameras;

  var isCameraInitialized = false.obs;
  var cameraCount = 0;
  
  var x, y, w, h = 0.0;
  var label = "";

  @override
  void onInit(){
    super.onInit();
    initCamera();
    initTFLite();
  }

  @override
  void dispose(){
    super.dispose();
    cameraController.dispose();
  }

  initCamera() async{
    if(await Permission.camera.request().isGranted){
      cameras = await availableCameras();
      cameraController = CameraController(cameras[0], ResolutionPreset.max);

      await cameraController.initialize().then((value) {
          cameraController.startImageStream((image) {
            cameraCount++;
            if(cameraCount % 10 == 0){
              cameraCount = 0;
              objectDetector(image);
            }

            update();
            
          });
      });
      isCameraInitialized(true);
      update();
    }else{

    }
  }

  initTFLite() async{
    await Tflite.loadModel(
      model: "assets/mobilenet_model.tflite",
      labels: "assets/label.txt",
      isAsset: true,
      numThreads: 1,
      useGpuDelegate: false
    );
  }

  objectDetector(CameraImage image) async{
    var detector = await Tflite.detectObjectOnFrame(bytesList: image.planes.map((e) {
        return e.bytes;
      }).toList(),
      imageHeight: image.height,
      imageWidth: image.width,
      rotation: 90,
      asynch: true,
      imageMean: 127.5,
      imageStd: 127.5,
      numResultsPerClass: 1,
      threshold: 0.4
    );

    if(detector != null){
      if(detector.isNotEmpty){
        var detectedObj = detector.first;
        print(detectedObj);
        if(detectedObj['confidenceInClass'] * 100 > 70){
          label = detectedObj['detectedClass'].toString();
          h = detectedObj['rect']['h'];
          w = detectedObj['rect']['w'];
          x = detectedObj['rect']['x'];
          y = detectedObj['rect']['y'];
        }
        update();
      }
      
    }
  }

  Future<String> saveImage(String objText) async {
    
    final appDir = await getTemporaryDirectory();
    final appPath = appDir.path;
    final fileOnDevice = File('$appPath/$objText.jpg');

    if(await fileOnDevice.exists()){
      await FileImage(fileOnDevice).evict();
      await fileOnDevice.delete();
    }
    try{
      final image = await cameraController.takePicture();
      final oriImg = File(image.path);
      final renamedImg = await oriImg.rename(fileOnDevice.path);

      return renamedImg.path;
      
    }catch(e){
      return '';
    }
  }
}