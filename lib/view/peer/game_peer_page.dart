// ignore_for_file: use_build_context_synchronously

import 'package:visio/constant/constant_builder.dart';
import 'package:visio/constant/firebase_constant.dart';
import 'package:visio/factory/game_factory.dart';
import 'package:visio/view/peer/describe_peer_page.dart';
import 'package:visio/view/peer/official_game_card.dart';


class GamePeer extends StatefulWidget {
  const GamePeer({super.key});
  @override
  State<GamePeer> createState() => _GamePeerState();
}

class _GamePeerState extends State<GamePeer> {
  TextEditingController textController = TextEditingController();

  String errorText = "";
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Describe With Friend!'),
        backgroundColor: appOrange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Find A Game',
              style: styleB30
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: lightBlue,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Enter game Code that\nis shared by your friends!',
                    style: styleSB20
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: textController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Type code here...',
                      filled: true,
                      fillColor: white,
                    ),
                  ),
                  Text(
                    errorText,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.red),
                  ),
                  const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            findGame();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: appOrange,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text('Play!',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ))),
                    ),
                ],
              ),
            ),
            
            const SizedBox(height: 15),
            const SizedBox(
              width: double.infinity,
              child: Text(
                'OR',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 25,
                    color: fontColor),
              ),
            ),
            const SizedBox(
              width: double.infinity,
              child: Text(
                'Play Official Games!',
                textAlign: TextAlign.center,
                style: styleB25
              ),
            ),
            const SizedBox(height: 20),
            StreamBuilder<QuerySnapshot>(
                stream: getGame
                    .where('createdBy', isEqualTo: 'Carbonara')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Column(children: [
                      skeletonBox(double.infinity, 80),
                    ]);
                  } else if (snapshot.data!.docs.isEmpty) {
                    return Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Image(image: AssetImage(sickills), width: 70),
                          Text(
                            'No official game',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: fontColor.withOpacity(0.5),
                            ),
                          )
                        ],
                      ),
                    );
                  } else {
                    return Column(
                      children: (snapshot.data!).docs.map((e) {
                        List<dynamic> items = e['obj'];
                        List<ItemObject> itemObject = items
                            .map((e) => ItemObject(
                                image: e['image'],
                                objName: e['objName'],
                                description: e['description'],
                                colaboratorDesc: e['colaboratorDesc']))
                            .toList();
                        Game gameObj = Game(
                            place: e['place'],
                            obj: itemObject,
                            code: e['code'],
                            createdBy: e['createdBy'],
                            playedBy: e['playedBy'],
                            createdTime: e['createdTime'],
                            colaboratorTime: e['colaboratorTime'],
                            isPlayed: e['isPlayed'],
                            colaboratorUid: e['colaboratorUid']);
                        return OfficialGameCard(gameObj, 'Carbonara');
                      }).toList(),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }

  Future<void> findGame() async{
    if(textController.text == ""){
      setState(() {
        errorText = "Please enter the game code!";
      });
      Future.delayed(const Duration(seconds: 3), () {
        setState(() {
          errorText = '';
        });
      });
    }else {
      try {
        DocumentReference docRef =
            db.collection('games').doc(textController.text);
        var docSnapshot = await docRef.get();

        if (docSnapshot.exists) {
          final data =
              docSnapshot.data() as Map<String, dynamic>;

          List<dynamic> items = data['obj'];
          List<ItemObject> itemObject = items.map(
            (e) {
              return ItemObject(
                image: e['image'],
                objName: e['objName'],
                description: e['description'],
                colaboratorDesc: e['colaboratorDesc'],
              );
            },
          ).toList();

          Game game = Game(
              code: data['code'],
              place: data['place'],
              createdBy: data['createdBy'],
              createdTime: data['createdTime'],
              colaboratorTime: data['colaboratorTime'],
              playedBy: data['playedBy'],
              isPlayed: data['isPlayed'],
              colaboratorUid: data['colaboratorUid'],
              obj: itemObject);

          if(game.isPlayed == false){
            textController.clear();
            setState(() {
              errorText = "";
            });
            
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      DescribePeerPage(game, 0, false)),
            );
          }else{
            setState(() {
              errorText = "Game is already played";
            });
          }
          
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Game does not exists'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error Code: $e'),
              backgroundColor: Colors.red,
            ),
          );
      }
    }
  }
}
