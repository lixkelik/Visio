import 'package:visio/constant/constant_builder.dart';
import 'package:visio/constant/firebase_constant.dart';
import 'package:visio/factory/game_factory.dart';
import 'package:visio/view/impaired/texttospeech.dart';
import 'package:visio/view/widget/history_impaired_card.dart';

class HistoryImpairedPage extends StatefulWidget {
  final String uid;
  const HistoryImpairedPage(this.uid, {super.key});

  @override
  State<HistoryImpairedPage> createState() => _HistoryImpairedPageState();
}

class _HistoryImpairedPageState extends State<HistoryImpairedPage> {
  

  List<Game> gameList = [];

  @override
  void initState() {
    pageSpeech();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Game History',
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: fontColor)),
            const SizedBox(height: 15),
            StreamBuilder<QuerySnapshot>(
            stream: getGame
                .orderBy('createdTime', descending: true)
                .where('createdBy', isEqualTo: widget.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Column(children: [
                  skeletonBox(double.infinity, 138),
                  const SizedBox(height: 15),
                  skeletonBox(double.infinity, 138),
                ]);
              } else if (snapshot.data!.docs.isEmpty) {
                  return SizedBox(
                    width: double.infinity,
                    height: 450,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Image(
                          image: AssetImage(inspired),
                          width: 180,
                        ),
                        Text(
                          'No History Found\nPlay a game first!',
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
                    return HistoryImpairedCard(gameObj, widget.uid);
                  }).toList(),
                );
              }
            })
          ],
          ),
        ));
  }

  void pageSpeech() {
    textToSpeech('You are at: History Page!');
  }
}
