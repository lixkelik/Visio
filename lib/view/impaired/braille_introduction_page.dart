import "package:visio/constant/constant_builder.dart";
import "package:visio/view/impaired/braille_letter_introduction_page.dart";

class BrailleIntroductionPage extends StatelessWidget {
  const BrailleIntroductionPage({super.key});

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Introduction",
                      style: styleB30,
                    ),
                    const Text(
                      "A braille character is represented with a cell. A cell contains of 6 dots. Each dots are represented with number 1 to 6.",
                      style: styleR15,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Single tap to hear the dot, double tap to select or deselect. Try to touch each dots! ",
                      style: styleB15,
                    ),
                    
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: (() => Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => BrailleLetterIntroductionPage()),
                    )), 
                      style: ElevatedButton.styleFrom(
                        backgroundColor: appOrange,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text('Go Back',
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
