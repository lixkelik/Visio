import 'package:visio/constant/constant_builder.dart';
import 'package:visio/factory/game_factory.dart';
import 'package:visio/view/impaired/scan_obj_page.dart';
import 'package:visio/view/impaired/speechtotext.dart';
import 'package:visio/view/impaired/texttospeech.dart';

class GameImpaired extends StatefulWidget {
  const GameImpaired({super.key});

  @override
  State<GameImpaired> createState() => _GameImpairedState();
}

class _GameImpairedState extends State<GameImpaired> {

  bool speechEnabled = false;
  String lastWord = '';
  TextEditingController textController = TextEditingController();
  List<ItemObject> items = [];

  @override
  void initState() {
    pageSpeech();
    _initSpeech();
    items = [];
    super.initState();
  }

  void _initSpeech() async {
    speechEnabled = await speech.initialize();
    setState(() {});
  }

  void _startListening() async {
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
    return  Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 38, right: 38, top: 80),
          child: Column(
            children: [
              const Text(
                'Scan 5 objects around you and describe them',
                softWrap: true,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  color: fontColor,
                )
              ),
              const SizedBox(height: 35),
              const Text(
                'Where are you?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
      
                )
              ),
              
              const SizedBox(height: 15),
              TextField(
                maxLength: 20,
                controller: textController,
                decoration: const InputDecoration(
                  fillColor: Color(0xffE9E9E9),
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  hintText: 'Enter text here Or talk',
                ),
              ),
      
              const SizedBox(height: 15),
      
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (){
                    if(textController.text.isNotEmpty || textController.text != ''){
                      String text = textController.text;
                      textController.clear();
                      items.clear();
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => ScanObjectPage(text, items))
                      );
                    }else{
                      textToSpeech('Please tell me where are you first!');
                    }
                  },
                  
                  style: ElevatedButton.styleFrom(
                    backgroundColor: appOrange,
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Start Playing!',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    )
                  )
                ),
              ),

              const SizedBox(height: 80),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white, 
                  backgroundColor: appOrange,
                  fixedSize: const Size(130, 130),
                  
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
                
              ),
            ],
          ),
        ),
      ),
    );
  }

  void pageSpeech(){
    textToSpeech('You are at: game page!, lets play a game and scan 5 objects. Start by tell me where you are.');
  }

}