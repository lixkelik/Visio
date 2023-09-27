import 'dart:async';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:camera/camera.dart';
import 'package:visio/constant/constant_builder.dart';
import 'package:visio/tflite/camera_view1.dart';
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
  /// Results to draw bounding boxes
  List<Recognition>? results;

  Timer? _timer;

  String objText = '';
  String responseGPT = '';
  late ResponseModel _responseModel;

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  void initState() {
    pageSpeech();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Camera View
          const CameraViewScreen(),

          // Bottom Sheet
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.maxFinite,
              height: 221,
              decoration: const BoxDecoration(
                color: Colors.white,
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
                        // 2 button
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
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
                              foregroundColor: Colors.white,
                              backgroundColor: appOrange,
                              fixedSize: const Size(120, 120),
                              shape: const CircleBorder(),
                              alignment: Alignment.center,
                            ),
                            onPressed: () {
                              // tampilin pop up

                              if (objText == '') {
                                textToSpeech("No object detected!");
                              } else {
                                completionFun().then((_) {
                                  textToSpeech(responseGPT);
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        contentPadding: const EdgeInsets.all(16.0),
                                        content: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                // icon untuk close
                                                IconButton(
                                                  icon: const Icon(Icons.close),
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pop();
                                                  },
                                                ),
                                              ],
                                            ),

                                            // icon content
                                            // button
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  top: 16),
                                              child: Center(
                                                child: TextButton(
                                                  style: TextButton.styleFrom(
                                                    foregroundColor:
                                                        Colors.white,
                                                    backgroundColor:
                                                        appOrange,
                                                    fixedSize:
                                                        const Size(120, 120),
                                                    shape:
                                                        const CircleBorder(),
                                                    alignment:
                                                        Alignment.center,
                                                  ),
                                                  onPressed: () {
                                                    if (responseGPT == '') {
                                                      textToSpeech(
                                                          "No definition!");
                                                    } else {
                                                      textToSpeech(
                                                          responseGPT);
                                                    }
                                                  },
                                                  child: const Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .volume_up_rounded,
                                                        size: 37,
                                                      ),
                                                      Text(
                                                        'Hear',
                                                        style: TextStyle(
                                                            fontSize: 18),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 16),
                                            // text
                                            Center(
                                              child: Text(
                                                objText,
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Center(child: Text(responseGPT)),
                                          ],
                                        ),
                                      );
                                    },
                                  );
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
                        // 2 button selesai
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
    if (mounted) {
      setState(() {
        this.results = results;
        if (results.isNotEmpty) {
          if (objText != results.last.label) {
            textToSpeech(results.last.label);
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

  void pageSpeech() {
    textToSpeech('You are at: Explore Page!');
  }

  completionFun() async {
    if(mounted){
      setState(() => responseGPT = 'Loading..');
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
                  'Explain briefly under 30 words about daily object named $objText',
              'max_tokens': 50,
              'temperature': 0,
              'top_p': 1
            }));
    
    if(mounted){
      setState(() {
        _responseModel = ResponseModel.fromJson(json.decode(response.body));
        responseGPT = _responseModel.choices[0].text;
      });
    }
  }
}
