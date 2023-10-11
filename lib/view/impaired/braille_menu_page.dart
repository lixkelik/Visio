import "package:visio/constant/constant_builder.dart";
import "package:visio/view/impaired/braille_introduction_page.dart";
import "package:visio/view/impaired/braille_letter_introduction_page.dart";

class BrailleMenuPage extends StatelessWidget {
  const BrailleMenuPage({super.key});

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
                                              const BrailleLetterIntroductionPage()));
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
                          const Text('A - E', style: styleB20),
                        ],
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      // ini bulat kedua
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
                                onPressed: () {},
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
                    ],
                  )
                ],
              )),
        ]),
      ),
    );
  }
}
