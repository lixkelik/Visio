import 'dart:async';

import 'package:camera/camera.dart';
import 'package:visio/constant/constant_builder.dart';
import 'package:visio/factory/game_factory.dart';
import 'package:visio/tflite/image_utils.dart';
import 'package:visio/tflite/recognition.dart';
import 'package:visio/tflite/box_widget.dart';
import 'package:visio/view/impaired/describe_page.dart';
import 'package:visio/view/impaired/texttospeech.dart';

import '../../tflite/camera_view.dart';

/// [HomeView] stacks [CameraView] and [BoxWidget]s with bottom sheet for stats
class ScanObjectPage extends StatefulWidget {

  final String title;
  final List<ItemObject> objects;
  

  const ScanObjectPage(this.title, this.objects, {super.key});

  @override
  State<ScanObjectPage> createState() => _ScanObjectPageState(title, objects);
}

class _ScanObjectPageState extends State<ScanObjectPage> {

  String title;
  List<ItemObject> objects; 

  _ScanObjectPageState(
    this.title,
    this.objects
  );

  /// Results to draw bounding boxes
  List<Recognition>? results;
  CameraImage? _currentImage;

  Timer? _timer;

  String objText = '';

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          // Camera View
          CameraView(resultsCallback),
          
          // Bounding boxes
          boundingBoxes(results),

          // Bottom Sheet
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.maxFinite,
              height: 280,
              decoration: const BoxDecoration(
                  color: Colors.white,),
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        objText,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: fontColor,            
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(top: 16),
                              child: TextButton.icon(
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.white, 
                                  backgroundColor: appOrange,
                                  alignment: Alignment.center,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(0)),
                                  ),
                                ),
                                onPressed: () {
                                  if(objText == ''){
                                    textToSpeech("No object detected!");
                                  }else{
                                    textToSpeech(objText);
                                  }
                                  
                                },
                                icon: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.volume_up_rounded, size: 50,),
                                    Text(
                                      'Speak',
                                      style: TextStyle(
                                        fontSize: 25
                                      )
                                    )
                                  ],
                                ), 
                                label: const SizedBox.shrink()
                              ),
                            ),
                          ),

                          const SizedBox(width: 5),

                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(top: 16),
                              child: TextButton.icon(
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.white, 
                                  backgroundColor: appOrange,
                                  alignment: Alignment.center,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(0)),
                                  ),
                                ),
                                onPressed: () async {
                                  if(objText != ''){
                                    bool flag = true;
                                    for(var obj in objects){
                                      if(obj.objName == objText){
                                        flag = false;
                                        break;
                                      }
                                    }
                                    if(flag){
                                      if (_currentImage != null) {
                                        final rgbImage = ImageUtils.convertCameraImage(_currentImage!);
                                        if (rgbImage != null  && objText.isNotEmpty) {
                                          try {
                                            String image = await ImageUtils.saveImage(rgbImage, objText);
                                            if(image != ''){
                                              textToSpeech('$objText Saved! Now let\'s describe the object by touching it. You can describe the texture, the weight, the size, or the function of the object!');
                                              // ignore: use_build_context_synchronously
                                              Navigator.pushReplacement(
                                                context, 
                                                MaterialPageRoute(builder: (context) => DescribePage(title, image, objects, objText)),
                                              );
                                            }else{
                                              textToSpeech('error!');
                                            }
                                          } catch (e) {
                                            textToSpeech('An error occured, please try again later.');
                                          }
                                        }
                                      }
                                    }else{
                                      textToSpeech('Object duplicated, please find another object!');
                                    }
                                  }else{
                                    textToSpeech('No object detected!');
                                  }
                                }, 
                                icon: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.photo_camera, size: 50,),
                                    Text(
                                      'Save',
                                      style: TextStyle(
                                        fontSize: 25
                                      )
                                    )
                                  ],
                                ), 
                                label: const SizedBox.shrink()
                              ),
                            ),
                          ),

                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Returns Stack of bounding boxes
  Widget boundingBoxes(List<Recognition>? results) {
    if (results == null) {
      return Container();
    }
    return Stack(
      children: results
          .map((e) => BoxWidget(
                result: e,
              ))
          .toList(),
    );
  }

  /// Callback to get inference results from [CameraView]
  void resultsCallback(List<Recognition> results, CameraImage image) {
    if(mounted){
      setState(() {
        this.results = results;
        if(results.isNotEmpty){
          if(objText != results.last.label){
            textToSpeech(results.last.label);
          }
          objText = results.last.label;
          clearObjText();
          _currentImage = image;
        }
      });
    }
  }
  void clearObjText() async{
    _timer?.cancel();
    _timer = Timer(const Duration(seconds: 1), (() =>  objText=''));
  }
}