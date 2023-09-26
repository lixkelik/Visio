import 'package:visio/constant/constant_builder.dart';
import 'package:visio/constant/firebase_constant.dart';
import 'package:visio/factory/game_factory.dart';

import '../widget/history_peer_card.dart';

class HistoryPeerPage extends StatefulWidget {
  final String uid;
  const HistoryPeerPage(this.uid, {super.key});

  @override
  State<HistoryPeerPage> createState() => _HistoryPeerPageState();
}

class _HistoryPeerPageState extends State<HistoryPeerPage> {

  List<Game> gameList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 65),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Game History',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: fontColor)),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: StreamBuilder<QuerySnapshot>(
                  stream: getGame
                      .orderBy('createdTime', descending: true)
                      .where('colaboratorUid', isEqualTo: widget.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Column(children: [
                        skeletonBox(double.infinity, 125),
                        const SizedBox(height: 15),
                        skeletonBox(double.infinity, 125),
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
                          return HistoryPeerCard(gameObj, widget.uid);
                        }).toList(),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
