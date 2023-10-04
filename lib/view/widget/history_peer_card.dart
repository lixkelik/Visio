import 'package:visio/constant/constant_builder.dart';
import 'package:visio/factory/game_factory.dart';
import 'package:visio/view/review_page.dart';
import 'package:intl/intl.dart';

class HistoryPeerCard extends StatelessWidget {
  final Game gameObj;
  final String uid;
  const HistoryPeerCard(this.gameObj, this.uid, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 15),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        color: appOrange
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      gameObj.place,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: white),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    
                  ],
                ),
                const SizedBox(height: 5,),
                Row(
                  children: [
                    const Icon(
                      Icons.history,
                      color: white,
                      size: 18,
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Text(
                      DateFormat('dd-MMMM-yyyy, HH:mm')
                          .format(gameObj.colaboratorTime.toDate()),
                      style: const TextStyle(
                          fontSize: 12, color: white),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>ReviewPage(gameObj, 0, uid, 2))
              );
            },
            child: Container(
              decoration: const BoxDecoration(
                color: green,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30)
                )
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 7),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('See Result',
                        style: TextStyle(
                            fontSize: 20,
                            color: white,
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.arrow_right_rounded,
                      color: white,
                      size: 40,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
