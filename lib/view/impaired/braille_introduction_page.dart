import "package:visio/constant/constant_builder.dart";
import "package:visio/view/impaired/braille_letter_introduction_page.dart";

class BrailleIntroductionPage extends StatefulWidget {
  const BrailleIntroductionPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BrailleIntroductionPage createState() => _BrailleIntroductionPage();
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
                    "Single tap to hear the dot, double tap to select or deselect. Try to touch each dots! ",
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  toggleNumber((row * 3) + col + 1);
                                });
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  selectedNumbers.contains((row * 3) + col + 1)
                                      ? Colors.blue
                                      : Colors.grey,
                                ),
                              ),
                              child: Text('${number}'),
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
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Selected Numbers'),
                            content: Text(selectedNumbers.join(', ')),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'),
                              ),
                            ],
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
}
