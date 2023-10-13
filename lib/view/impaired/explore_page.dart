import 'dart:async';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:camera/camera.dart';
import 'package:visio/constant/constant_builder.dart';
import 'package:visio/tflite/recognition.dart';
import 'package:visio/tflite/box_widget.dart';
import 'package:visio/view/impaired/texttospeech.dart';

import 'package:visio/factory/response_model.dart';
import '../../tflite/camera_view.dart';
import 'package:http/http.dart' as http;

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  List<Recognition>? results;

  Timer? _timer;

  String objText = '';
  String responseGPT = '';
  bool _isLearning = false;
  late ResponseModel _responseModel;

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    textToSpeech('You are at: Explore Page.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          CameraView(resultsCallback),

          boundingBoxes(results),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.maxFinite,
              height: 221,
              decoration: const BoxDecoration(
                color: white,
              ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: white,
                              backgroundColor: appOrange,
                              fixedSize: const Size(120, 120),
                              shape: const CircleBorder(),
                              alignment: Alignment.center,
                            ),
                            onPressed: () {
                              if (objText == '') {
                                textToSpeech("No object detected!");
                              } else {
                                textToSpeech(objText);
                              }
                            },
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.volume_up_rounded,
                                  size: 37,
                                ),
                                Text(
                                  'Hear',
                                  style: TextStyle(fontSize: 18),
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: white,
                              backgroundColor: appOrange,
                              fixedSize: const Size(120, 120),
                              shape: const CircleBorder(),
                              alignment: Alignment.center,
                            ),
                            onPressed: () {
                              if (objText == '') {
                                textToSpeech("No object detected!");
                              } else {
                                completionFun().then((_) {
                                  textToSpeech(responseGPT);
                                  showLearnDialog();
                                });
                              }
                            },
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.school_rounded,
                                  size: 37,
                                ),
                                Text(
                                  'Learn',
                                  style: TextStyle(fontSize: 18),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
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
    if (mounted) {
      setState(() {
        this.results = results;
        if (results.isNotEmpty) {
          if (objText != results.last.label) {
            if(_isLearning == false){
              textToSpeech(results.last.label);
            }
          }
          objText = results.last.label;
          clearObjText();
        }
      });
    }
  }

  void clearObjText() async {
    _timer?.cancel();
    _timer = Timer(const Duration(seconds: 2), (() => objText = ''));
  }

  completionFun() async {
    if(mounted){
      setState(() {
         responseGPT = 'Loading..';
         _isLearning = true;
      });
    }
    final response =
        await http.post(Uri.parse('https://api.openai.com/v1/completions'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer ${dotenv.env['token']}',
            },
            body: jsonEncode({
              'model': 'gpt-3.5-turbo-instruct',
              'prompt':
                  'Explain briefly under 30 words about daily object named $objText and explain it like you explain to a children with visually impaired, also tell them an important fact about the object!',
              'max_tokens': 80,
              'temperature': 0,
              'top_p': 1
            }));
    
    if(mounted){
      setState(() {
        _responseModel = ResponseModel.fromJson(json.decode(response.body));
        responseGPT = _responseModel.choices[0].text;
        responseGPT = responseGPT.replaceAll('\n\n', '');
      });
    }
  }

  void showLearnDialog(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30)
          ),
          child: Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      setState(() {
                        _isLearning = false;
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    objText,
                    style: styleSB20,
                  ),
                ),
                const SizedBox(height: 10,),
                Center(child: Text(responseGPT)),
                const SizedBox(height: 10,),
                Center(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: white,
                      backgroundColor: appOrange,
                      fixedSize: const Size(120, 120),
                      shape: const CircleBorder(),
                      alignment: Alignment.center,
                    ),
                    onPressed: () async {
                      if (responseGPT == '') {
                        textToSpeech("No definition!");
                      } else {
                        textToSpeech(responseGPT);
                        await flutterTts.awaitSpeakCompletion(true).then((value) async {
                          setState(() {
                            _isLearning = false;
                          });
                          await flutterTts.awaitSpeakCompletion(false);
                        });
                      }
                    },
                    child: const Column(
                      mainAxisAlignment:MainAxisAlignment.center,
                      children: [
                        Icon(Icons.volume_up_rounded, size: 37),
                        Text(
                          'Hear',
                          style: TextStyle(
                            fontSize: 18
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
