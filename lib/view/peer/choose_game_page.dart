import "package:visio/constant/constant_builder.dart";
import "package:visio/view/peer/game_peer_page.dart";
import "package:visio/view/peer/learn_game_page.dart";

class ChooseGamePage extends StatelessWidget {
  const ChooseGamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Choose & play a game",
              style: styleB25,
            ),
            const SizedBox(height: 20,),
            InkWell(
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => const GamePeer()));
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: appOrange,
                    width: 3
                  ),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(play, width: 110, height: 110),
                    const SizedBox(height: 10),
                    Text(
                      'Describe with a\nfriend',
                      style: styleR20,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10,),
            InkWell(
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => const LearnGamePage()));
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: appOrange,
                    width: 3
                  ),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(learn, width: 110, height: 110),
                    const SizedBox(height: 10),
                    Text(
                      'Learn about your\nsurrounding',
                      style: styleR20,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}