import 'dart:io';

import 'package:visio/constant/constant_builder.dart';
import 'package:visio/constant/firebase_constant.dart';
import 'package:visio/factory/game_factory.dart';
import 'package:visio/view/impaired/loading_page.dart';
import 'package:visio/view/impaired/scan_obj_page.dart';
import 'package:visio/view/impaired/speechtotext.dart';
import 'package:visio/view/impaired/texttospeech.dart';

class DescribePage extends StatefulWidget {
  final String title;
  final String image;
  final String objName;
  final List<ItemObject> objects;
  const DescribePage(this.title, this.image, this.objects, this.objName, {super.key});
  
  @override
  // ignore: no_logic_in_create_state
  State<DescribePage> createState() => _DescribePageState(title, image, objects, objName);
}

class _DescribePageState extends State<DescribePage> {

  String title;
  String image;
  List<ItemObject> objects;
  String objName;

  _DescribePageState(
    this.title,
    this.image,
    this.objects,
    this.objName
  );

  bool speechEnabled = false;
  String lastWord = '';
  TextEditingController textController = TextEditingController();
  File? img;
  
  @override
  void initState() {
    img = File(image);
    _initSpeech();
    _evictImage();
    super.initState();
  }

  void _initSpeech() async {
    speechEnabled = await speech.initialize();
    setState(() {});
  }

  void _startListening() async {
    await flutterTts.stop();
    await speech.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  void _stopListening() async {
    await speech.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWord = result.recognizedWords;
      textController.text = lastWord;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Transform.rotate(
            angle: 3.14 / 2,
            child: SizedBox(
              height: 392.75,
              child: 
              (img != null)
              ? Image.file(
                  img!,
                  fit: BoxFit.cover,
                  key: ValueKey(DateTime.now().millisecondsSinceEpoch),
                )
              : const Center(child: CircularProgressIndicator(),)
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 270),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: lightBlue,
                      borderRadius: BorderRadius.circular(30)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Touch & describe it!',
                          style: styleB25,
                        ),
                        const SizedBox(height: 10,),
                        const Text(
                          'What is the texture? Is it soft or hard? and the weight, is it light or heavy? How about the size? Is it big or small? What is the function of the object?',
                          softWrap: true,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 13,
                            color: fontColor
                          )
                        ),
                        const SizedBox(height: 15),
                        TextField(
                          maxLength: 200,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          controller: textController,
                          decoration: const InputDecoration(
                            fillColor: white,
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(Radius.circular(30))
                            ),
                            hintText: 'Enter text here Or talk',
                          ),
                        ),
                      ]
                    ),
                  ),
                  const SizedBox(height: 10,),
                  SizedBox(
                    width: double.maxFinite,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white, 
                        backgroundColor: appOrange,
                        fixedSize: const Size(120, 120),
                        shape: const CircleBorder(),
                        
                      ),
                      onPressed: () => speech.isNotListening ? _startListening() : _stopListening(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children:  [
                          Icon(
                            speech.isNotListening ? Icons.mic_off : Icons.mic, 
                            size: 35,
                          ),
                          const Text(
                            'Speak',
                            style: TextStyle(
                              fontSize: 16
                            ),
                          )
                        ],
                      ), 
                    )
                  ),
                  const SizedBox(height: 10,),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: (){
                        if(textController.text.isNotEmpty || textController.text != ''){
                          String description = textController.text;
                          ItemObject item = ItemObject(image: image, objName: objName, description: description, colaboratorDesc: '-');
                          objects.add(item);
                          if(objects.length < 5) {
                            Navigator.pushReplacement(
                              context, 
                              MaterialPageRoute(builder: (context) => ScanObjectPage(title, objects))
                            );
                          }else{
                            Game gameObj = Game(place: title, obj: objects, code: '', createdTime: Timestamp.now(), createdBy: '', playedBy: '-', isPlayed: false, colaboratorUid: '-', colaboratorTime: Timestamp.now());
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => LoadingPage(gameObj))
                            );
                          }
                        }else{
                          textToSpeech('Please tell me the description of the object first!');
                        }
                      },
                      
                      style: ElevatedButton.styleFrom(
                        backgroundColor: appOrange,
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Next!',
                        style: styleWSB25
                      )
                    ),
                  ),
                ]
              ),
            ),
          ),
        ]
      ),
    );
  }
  Future<void> _evictImage()async{
    await FileImage(img!).evict();
    setState(() {});
  }
}