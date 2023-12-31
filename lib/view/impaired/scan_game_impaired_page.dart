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
    super.initState();
    textToSpeech('Lets play a game and scan 3 objects. Start by telling me where you are.');
    _initSpeech();
    items = [];
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
    return  Scaffold(
      appBar: AppBar(
        leading: Container(
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: appOrange.withOpacity(0.7),
            shape: BoxShape.circle
          ),
          child: IconButton(
            onPressed: (() => Navigator.pop(context)), 
            icon: const Icon(Icons.arrow_back),
            tooltip: MaterialLocalizations.of(context).backButtonTooltip,
            splashRadius: 24,
            color: white,
            padding: EdgeInsets.zero,
            alignment: Alignment.center,
            iconSize: 24,
            enableFeedback: true,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
        child: Column(
          children: [
            Image.asset(
              readills,
              width: 92,
              height: 113,
            ),
            const Text(
              'Let\'s Play!',
              textAlign: TextAlign.center,
              style: styleB35
            ),
            const Text(
              'Scan 3 objects around\nyou and describe them',
              softWrap: true,
              textAlign: TextAlign.center,
              style: styleR20
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.all(15),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: lightPink,
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Where are you?',
                    textAlign: TextAlign.center,
                    style: styleB25
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    maxLength: 20,
                    controller: textController,
                    decoration: const InputDecoration(
                      fillColor: white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(30))
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(30))
                      ),
                      hintText: 'Enter text here Or talk',
                    ),
                  ),
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
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Start Playing!',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: white,
                        )
                      )
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: white, 
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
              
            ),
          ],
        ),
      ),
    );
  }
}