import "dart:convert";
import 'dart:core';
import "package:flutter/services.dart";
import "package:visio/constant/constant_builder.dart";
import "package:visio/model/braille.dart";
import "package:visio/model/letter.dart";
import "package:visio/view/impaired/braille_introduction_page.dart";
import "package:visio/view/impaired/braille_letter_introduction_page.dart";
import "package:visio/view/impaired/texttospeech.dart";

class BrailleMenuPage extends StatefulWidget {
  const BrailleMenuPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BrailleMenuPage createState() => _BrailleMenuPage();
}

class _BrailleMenuPage extends State<BrailleMenuPage> {
  List<Braille> blocks = [];

  @override
  void initState() {
    super.initState();
    loadBrailleData();
    pageSpeech();
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
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            "Braille Letters",
            style: styleB30,
          ),
          const Text(
            "Braille is a special way of reading and writing. It uses tiny raised dots that you can touch with your fingers to feel letters and words.",
            style: styleR15,
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  // introduction
                  // ini 1 bulat
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 10, // outer border width
                            color: whiteGrey,
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 5, // inner border width
                              color: Colors.white,
                            ),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const BrailleIntroductionPage()));
                            },
                            child: Image.asset(
                              helloills, // Replace with your image asset path
                              width: 70,
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: lightPink,
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(20),
                            ),
                          ),
                        ),
                      ),
                      const Text('Introduction', style: styleB20),
                    ],
                  ),

                  // selesai 1 bulat

                  const SizedBox(height: 12),
                  // Other data
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // ini bulat pertama
                      for (Braille braille in blocks)
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 10, // outer border width
                                  color: whiteGrey,
                                ),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 5, // inner border width
                                    color: Colors.white,
                                  ),
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BrailleLetterIntroductionPage(
                                                    brailleData: braille)));
                                  },
                                  child: Image.asset(
                                    braille.imgPath,
                                    width: 70,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: lightPink,
                                    shape: CircleBorder(),
                                    padding: EdgeInsets.all(20),
                                  ),
                                ),
                              ),
                            ),
                            Text(braille.title, style: styleB20),
                          ],
                        ),
                      const SizedBox(
                        width: 15,
                      ),
                      // ini bulat kedua
                    ],
                  )
                ],
              )),
        ]),
      ),
    );
  }

  void pageSpeech() {
    textToSpeech(
        'Braille is a special way of reading and writing. It uses tiny raised dots that you can touch with your fingers to feel letters and words. Now select which letter do you want to learn!');
  }

  Future<void> loadBrailleData() async {
    final jsonString = await rootBundle.loadString('assets/data.json');
    final jsonData = json.decode(jsonString);

    if (jsonData.containsKey('block')) {
      for (var block in jsonData['block']) {
        if (block.containsKey('letter')) {
          List<Letter> brailleLetters =
              block['letter'].map<Letter>((letterData) {
            return Letter(
              letterName: letterData['letter_name'],
              letterDesc: letterData['letter_desc'],
              letterDots: List<int>.from(letterData['letter_dots']),
            );
          }).toList();

          final brailleBlock = Braille(
            title: block['title'],
            description: block['description'],
            imgPath:
                block['imgPath'], // If you have an image path in your JSON.
            dots: List<int>.from(block['dots']),
            letterList: brailleLetters,
          );

          blocks.add(brailleBlock);
          setState(() {});
        }
      }
    }
  }
}
