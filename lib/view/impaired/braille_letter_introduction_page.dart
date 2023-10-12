import "package:visio/constant/constant_builder.dart";
import "package:visio/view/impaired/braille_letter_answer_page.dart";

class BrailleLetterIntroductionPage extends StatefulWidget {
  const BrailleLetterIntroductionPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BrailleLetterIntroductionPage createState() =>
      _BrailleLetterIntroductionPage();
}

class _BrailleLetterIntroductionPage
    extends State<BrailleLetterIntroductionPage> {
  List<int> selectedNumbers = [];
  List<int> correctAns = [1, 2, 4, 5];

  void toggleNumber(int number) {
    if (selectedNumbers.contains(number)) {
      selectedNumbers.remove(number);
    } else {
      selectedNumbers.add(number);
    }
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
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "A - E",
                          style: styleB30,
                        ),
                        Text(
                          "The letters A - E only use the top 4 dots in each cell. ",
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
                              builder: (context) =>
                                  const BrailleLetterAnswerPage()),
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
}
