import "package:visio/constant/constant_builder.dart";
import "package:visio/view/impaired/success_impaired_page.dart";

class BrailleLetterAnswerPage extends StatefulWidget {
  const BrailleLetterAnswerPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BrailleLetterAnswerPage createState() => _BrailleLetterAnswerPage();
}

class _BrailleLetterAnswerPage extends State<BrailleLetterAnswerPage> {
  List<int> selectedNumbers = [];
  List<int> correctAns = [1];

  void toggleNumber(int number) {
    if (selectedNumbers.contains(number)) {
      selectedNumbers.remove(number);
    } else {
      selectedNumbers.add(number);
    }
  }

  bool answerIsCorrect() {
    int len = (selectedNumbers.length <= correctAns.length)
        ? selectedNumbers.length
        : correctAns.length;
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
                        onPressed: () {},
                        child: const Icon(
                          Icons.volume_up_rounded,
                          size: 25,
                        ),
                      ),
                      const SizedBox(width: 20),
                      const Text(
                        "A",
                        style: styleB110,
                      ),
                    ],
                  ),
                  // text and letter
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "The letter A has dot 1 only, because A is the first letter of the alphabet.",
                        style: styleR15,
                      ),
                      Text(
                        "Try to touch dot 1!",
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
                                onTap: () {},
                                onDoubleTap: () {
                                  setState(() {
                                    toggleNumber((row * 3) + col + 1);
                                  });
                                },
                                child: Container(
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
            // end container braille
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 15),
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: (() {
                      // bottom pop up, validate the answer and show correct or not
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Image.asset(
                                  logoutills,
                                  width: 60,
                                ),
                                Text('Good Job, That is Correct!'),
                                ElevatedButton(
                                    onPressed: (() => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const SuccessImpairedPage()),
                                        )),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: appOrange,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 20),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                    child: const Text('Next',
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w600,
                                          color: white,
                                        ))),
                                // Add any widgets you want in the bottom pop-up
                              ],
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
}
