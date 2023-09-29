import "package:visio/constant/constant_builder.dart";
import "package:visio/view/peer/game_peer_page.dart";
import "package:visio/view/peer/learn_game_page.dart";

class ChooseGamePage extends StatelessWidget {
  const ChooseGamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 15),
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
              "There are two types of games.\nIf you want to help your friend to describe an object, choose describe with friend. If you want to learn something new, choose Learn about your surroundings!",
              style: styleR15,
            ),
            const SizedBox(height: 10,),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: lightPurple,
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context, 
                              MaterialPageRoute(builder: (context) => const GamePeer())
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: white,
                            padding: const EdgeInsets.all(5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: SizedBox(
                            height: 180,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  togetherills,
                                  height: 80,
                                ),
                                const Text(
                                  "Describe With\n Friend",
                                  style: styleSB15,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8,),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context, 
                              MaterialPageRoute(builder: (context) => const LearnGamePage())
                            );
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
                              borderRadius: BorderRadius.all(Radius.circular(30))
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  readills,
                                  height: 80,
                                ),
                                const Text(
                                  "Learn about your\n surroundings",
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
                  const SizedBox(height: 8,),
      
                  ElevatedButton(
                    onPressed: () {
                      showPopUp(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: white,
                      padding: const EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(30)
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            sickills,
                            height: 93,
                          ),
                          const Text(
                            "Another exciting game\nComing soon!",
                            style: styleSB15,
                            textAlign: TextAlign.center,
                          ),
                          
                        ],
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

  showPopUp(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30)
          ),
          child: Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(sickills, width: 60,),
                const SizedBox(height: 5),
                const Text('Coming Soon!', style: styleB20,),
                const Text('Keep supporting Visio\nand wait until new game released :D', style: styleR15, textAlign: TextAlign.center,),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: appOrange,
                    shape: const RoundedRectangleBorder(
                      
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    )
                  ),
                  child: const Text('Sure!'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}