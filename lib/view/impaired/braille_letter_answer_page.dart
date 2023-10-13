import "package:visio/constant/constant_builder.dart";
import "package:visio/model/braille.dart";
import "package:visio/view/impaired/success_impaired_page.dart";

import "texttospeech.dart";

class BrailleLetterAnswerPage extends StatefulWidget {
  final int counter;
  final Braille brailleData;

  const BrailleLetterAnswerPage(
      {super.key, required this.counter, required this.brailleData});

  @override
  State<BrailleLetterAnswerPage> createState() => _BrailleLetterAnswerPage();
}

class _BrailleLetterAnswerPage extends State<BrailleLetterAnswerPage> {
  List<int> selectedNumbers = [];
  List<int> correctAns = [];

  @override
  void initState() {
    super.initState();
    textToSpeech(widget.brailleData.letterList[widget.counter].letterDesc);
    correctAns = widget.brailleData.letterList[widget.counter].letterDots;
  }

  void toggleNumber(int number) {
    if (selectedNumbers.contains(number)) {
      selectedNumbers.remove(number);
    } else {
      selectedNumbers.add(number);
    }
  }

  bool answerIsCorrect() {
    selectedNumbers.sort();
    if (selectedNumbers.length != correctAns.length) {
      return false;
    }
    int len = selectedNumbers.length;
    for (int i = 0; i < len; i++) {
      if (selectedNumbers[i] != correctAns[i]) {
        return false;
      }
    }
    return true;
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
              child: Column(
                children: [
                  // hear circle
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: white,
                          backgroundColor: appOrange,
                          fixedSize: const Size(50, 50),
                          shape: const CircleBorder(),
                          alignment: Alignment.center,
                        ),
                        onPressed: () {
                          textToSpeech(widget.brailleData.letterList[widget.counter].letterDesc);
                        },
                        child: const Icon(
                          Icons.volume_up_rounded,
                          size: 25,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        widget
                            .brailleData.letterList[widget.counter].letterName,
                        style: styleB110,
                      ),
                    ],
                  ),
                  // text and letter
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget
                            .brailleData.letterList[widget.counter].letterDesc,
                        style: styleR15,
                      ),
                      Text(
                        "Try to touch dot ${widget.brailleData.letterList[widget.counter].letterDots.toString()}!",
                        style: styleB15,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // start container braille
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
                                onDoubleTap: () {
                                  int selectedNum = (row * 3) + col + 1;
                                  setState(() {
                                    toggleNumber(selectedNum);
                                  });
                                  selectedNumbers.contains((row * 3) + col + 1)
                                  ? speech("Dot ${selectedNum.toString()} Selected.")
                                  : speech("Dot ${selectedNum.toString()} Deselected.");
                                },
                                child: SizedBox(
                                  width: 80,
                                  height: 80,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // ((row * 3) + col + 1) utk tentukan number
                                      String numText = ((row * 3) + col + 1).toString();
                                      speech("This is dot number $numText.");
                                    },
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
                                      child: Text('$number', style: styleB35),
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
            // end container braille
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 15),
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: (() {
                      // bottom pop up, validate the answer and show correct or not
                      bool isCorrect = answerIsCorrect();
                      if(isCorrect){
                        textToSpeech("Good job, that is correct!");
                      }else{
                        textToSpeech("Wrong! Try again.");
                      }
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (BuildContext context) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              color: (isCorrect) ? lightGreen : lightPink,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        (isCorrect) ? kingills : sickills,
                                        width: 70,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        (isCorrect)
                                            ? 'Good Job,\nThat is Correct!'
                                            : 'Oops,\nTry Again',
                                        style: styleB25,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                        onPressed: (() {
                                          // cek apakah jawaban bener atau ga
                                          // bener -> ijo, salah -> merah
                                          if (isCorrect) {
                                            // kalo user click back dari hp, bakal ke select game
                                            if (widget.counter ==
                                                widget.brailleData.letterList
                                                        .length -
                                                    1) {
                                                      Navigator.pop(context);
                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                      // cek apakah semua letter udah ditampilin atau blm
                                                      builder: (context) =>
                                                          const SuccessImpairedPage()),
                                                  (route) => route.isFirst);
                                            } else {
                                               Navigator.pop(context);
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        BrailleLetterAnswerPage(
                                                      counter:
                                                          widget.counter + 1,
                                                      brailleData:
                                                          widget.brailleData,
                                                    ),
                                                  ));
                                            }
                                          } else {
                                            Navigator.of(context).pop();
                                          }
                                        }),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: appOrange,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 20),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                        ),
                                        child: Text(
                                            (isCorrect) ? 'Next' : 'Try Again',
                                            style: const TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.w600,
                                              color: white,
                                            ))),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: appOrange,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text('Submit',
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
  void speech(String text) {
    textToSpeech(text);
  }
}
