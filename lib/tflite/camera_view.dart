import 'dart:isolate';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:visio/tflite/classifier.dart';
import 'package:visio/tflite/recognition.dart';
import 'package:visio/tflite/isolate_utils.dart';
import 'package:visio/tflite/camera_view_singletion.dart';

class CameraView extends StatefulWidget {
  final Function(List<Recognition> recognitions, CameraImage) resultsCallback;


  const CameraView(this.resultsCallback, {super.key});
  @override
  // ignore: library_private_types_in_public_api
  _CameraViewState createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> with WidgetsBindingObserver {
  List<CameraDescription> cameras = [];
  CameraController? cameraController;
  late bool predicting;
  late Classifier classifier;
  late IsolateUtils isolateUtils;

  @override
  void initState() {
    super.initState();
    getCameras();
    initStateAsync();
  }

  Future<void> getCameras() async{
    cameras = await availableCameras();
  }

  void initStateAsync() async {
    WidgetsBinding.instance.addObserver(this);

    isolateUtils = IsolateUtils();
    await isolateUtils.start();

    await getCameras();
    initializeCamera();

    classifier = Classifier();
    predicting = false;
  }

  void initializeCamera() {
    cameraController = CameraController(cameras[0], ResolutionPreset.medium, enableAudio: false);
    Size s = MediaQuery.of(context).size;
    cameraController!.initialize().then((_) async {
      await cameraController!.startImageStream(onLatestImageAvailable);
      Size previewSize = cameraController!.value.previewSize!;

      CameraViewSingleton.inputImageSize = previewSize;

      Size screenSize = s;
      CameraViewSingleton.screenSize = screenSize;
      CameraViewSingleton.ratio = screenSize.width / previewSize.height;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(cameraController == null){
      return Container();
    }
    
    return CameraPreview(cameraController!);
  }

  onLatestImageAvailable(CameraImage cameraImage) async {
    if (predicting) {
      return;
    }
    if(mounted){
      setState(() {
        predicting = true;
      });
    }

    var isolateData = IsolateData(cameraImage, classifier.interpreter.address, classifier.labels);

    Map<String, dynamic> inferenceResults = await inference(isolateData);

    widget.resultsCallback(inferenceResults["recognitions"], cameraImage);

    if(mounted){
      setState(() {
        predicting = false;
      });
    }
  }

  Future<Map<String, dynamic>> inference(IsolateData isolateData) async {
    ReceivePort responsePort = ReceivePort();
    isolateUtils.sendPort.send(isolateData..responsePort = responsePort.sendPort);
    var results = await responsePort.first;
    return results;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.paused:
        cameraController!.stopImageStream();
        break;
      case AppLifecycleState.resumed:
        if (!cameraController!.value.isStreamingImages) {
          await cameraController!.startImageStream(onLatestImageAvailable);
        }
        break;
      default:
    }
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    if(cameraController != null){
      cameraController!.dispose();
    }
    isolateUtils.dispose();
  }
}