import "package:visio/constant/constant_builder.dart";

import "texttospeech.dart";

class BrailleIntroductionPage extends StatefulWidget {
  const BrailleIntroductionPage({super.key});

  @override
  State<BrailleIntroductionPage> createState() => _BrailleIntroductionPage();
}

class _BrailleIntroductionPage extends State<BrailleIntroductionPage> {
  List<int> selectedNumbers = [];

  void toggleNumber(int number) {
    if (selectedNumbers.contains(number)) {
      selectedNumbers.remove(number);
    } else {
      selectedNumbers.add(number);
    }
  }

  String printSortedArray(List<int> numbers) {
    numbers.sort();
    return numbers.join(', ');
  }

  @override
  void initState() {
    super.initState();
    textToSpeech('Introduction to braille. A braille character is represented with a cell. A cell contains of 6 dots. Each dots are represented with number 1 to 6. Single tap to hear the dot, double tap to select or deselect. Try to touch each dots!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: lightPink,
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
                color: white,
                borderRadius: BorderRadius.circular(30),
              ),
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Introduction",
                    style: styleB30,
                  ),
                  Text(
                    "A braille character is represented with a cell. A cell contains of 6 dots. Each dots are represented with number 1 to 6.",
                    style: styleR15,
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Single tap to hear the dot, double tap to select or deselect. Try to touch each dots!",
                    style: styleB15,
                  ),
                ],
              ),
            ),

            // braille dots
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
                                      String numText =
                                          ((row * 3) + col + 1).toString();
                                      speech("This is dot number $numText.");
                                    },
                                    
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(white),
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

            // button
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 15),
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      (selectedNumbers.isEmpty)
                      ? speech("Please select any dot number first!")
                      : speech("You have selected dot numbers: ${selectedNumbers.toString()}");
                      showDialog(
                        context: context,
                        builder: (context) {
                          // pop up result
                          return Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                    exitills,
                                    width: 60,
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    (selectedNumbers.isNotEmpty)
                                        ? 'You have selected dot numbers: '
                                        : 'Please select dot numbers!',
                                    style: styleB20,
                                  ),
                                  Text(
                                    printSortedArray(selectedNumbers),
                                    style: styleR20,
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 10),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.all(10),
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30)),
                                        )),
                                    child: const Text('Okay'),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
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
