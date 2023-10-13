import "package:visio/constant/constant_builder.dart";
import "package:visio/view/impaired/braille_menu_page.dart";
import 'package:visio/view/impaired/scan_game_impaired_page.dart';
import "package:visio/view/impaired/texttospeech.dart";

class SelectGamePage extends StatefulWidget {
  const SelectGamePage({super.key});

  @override
  State<SelectGamePage> createState() => _SelectGamePageState();
}

class _SelectGamePageState extends State<SelectGamePage> {
  @override
  void initState() {
    super.initState();
    textToSpeech('You are at: game page. Choose the game you want to play! tap to hear what game and double tap to choose the game.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Hey!",
              style: styleR20,
            ),
            const Text(
              "Let's play a game!",
              style: styleB30,
            ),
            const Text(
              "There are two types of games. You can describe objects in your surrounding or you can learn Braille character!",
              style: styleR15,
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: lightPurple,
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onDoubleTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const GameImpaired()));
                    },
                    child: ElevatedButton(
                      onPressed: () {
                        textToSpeech("Scan Object game");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: white,
                        padding: const EdgeInsets.all(5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Container(
                        height: 180,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: const BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.all(Radius.circular(30))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              togetherills,
                              height: 80,
                            ),
                            const Text(
                              "Scan & Describe Object Game",
                              style: styleSB15,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onDoubleTap: () {
                      Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BrailleMenuPage()));
                    },
                    child: ElevatedButton(
                      onPressed: () {
                        textToSpeech("Learn Braille game");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: white,
                        padding: const EdgeInsets.all(5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Container(
                        height: 180,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: const BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.all(Radius.circular(30))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              readills,
                              height: 80,
                            ),
                            const Text(
                              "Learn Braille",
                              style: styleSB15,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
