import "package:visio/constant/constant_builder.dart";
import "package:visio/model/braille.dart";
import "package:visio/view/impaired/braille_letter_answer_page.dart";
import "package:visio/view/impaired/texttospeech.dart";

class BrailleLetterIntroductionPage extends StatefulWidget {
  final Braille brailleData;
  const BrailleLetterIntroductionPage({Key? key, required this.brailleData})
      : super(key: key);

  @override
  State<BrailleLetterIntroductionPage> createState() =>
      _BrailleLetterIntroductionPage();
}

class _BrailleLetterIntroductionPage
    extends State<BrailleLetterIntroductionPage> {
  List<int> selectedNumbers = [];
  List<int> correctAns = [];

  void toggleNumber(int number) {
    if (selectedNumbers.contains(number)) {
      selectedNumbers.remove(number);
    } else {
      selectedNumbers.add(number);
    }
  }

  @override
  void initState() {
    super.initState();
    pageSpeech();
    correctAns = widget.brailleData.dots;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: Container(
          margin: const EdgeInsets.all(7),
          decoration: BoxDecoration(
              color: appOrange.withOpacity(0.7), shape: BoxShape.circle),
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
        physics: const BouncingScrollPhysics(),
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: lightBlue,
                borderRadius: BorderRadius.circular(30),
              ),
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Image.asset(exitills, width: 70),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.brailleData.title,
                          style: styleB30,
                        ),
                        Text(
                          widget.brailleData.description,
                          style: styleR15,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // braille dots container

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int row = 0, number = 1; row < 2; row++)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int col = 0; col < 3; col++, number++)
                          // setiap dots
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: ClipOval(
                              child: GestureDetector(
                                onTap: () {
                                  String numText =
                                      ((row * 3) + col + 1).toString();
                                  speech("This is dot number $numText.");
                                },
                                onDoubleTap: () {
                                  setState(() {
                                    toggleNumber((row * 3) + col + 1);
                                  });
                                },
                                child: SizedBox(
                                  width: 80,
                                  height: 80,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              (correctAns.contains(
                                                      (row * 3) + col + 1))
                                                  ? lightPink
                                                  : whiteGrey),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          side: BorderSide(
                                            color: selectedNumbers.contains(
                                                    (row * 3) + col + 1)
                                                ? Colors.red
                                                : Colors.transparent,
                                            width: 10,
                                          ),
                                        ),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text('${number}', style: styleB35),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                ],
              ),
            ),

            // end of braille dots container
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 15),
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: (() => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BrailleLetterAnswerPage(
                                  counter: 0, brailleData: widget.brailleData)),
                        )),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: appOrange,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text('Understood',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: white,
                        ))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void pageSpeech() {
    textToSpeech(
        'The letters A - E only use the top 4 dots in each cell. Tap to hear what the dots are. Double click to select or deselect the dot.');
  }

  void speech(String text) {
    textToSpeech(text);
  }
}
