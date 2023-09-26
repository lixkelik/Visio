import 'package:visio/constant/constant_builder.dart';
import 'package:visio/factory/game_factory.dart';
import 'package:visio/view/peer/describe_peer_page.dart';

class OfficialGameCard extends StatelessWidget {
  final Game gameObj;
  final String officialUid;
  const OfficialGameCard(this.gameObj, this.officialUid, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      width: double.infinity,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: appOrange),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            gameObj.place,
            style: const TextStyle(
              color: white,
              fontSize: 20,
              fontWeight: FontWeight.w600
            ),
            overflow: TextOverflow.fade,
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DescribePeerPage(gameObj, 0, true)));
          },
          child: Container(
            decoration: const BoxDecoration(
                color: green,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                )),
            padding: const EdgeInsets.all(8),
            width: 110,
            child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.play_circle_fill,
                    color: white,
                    size: 40,
                  ),
                  Text('Play',
                      style: TextStyle(
                          color: white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600))
                ]),
          ),
        )
      ]),
    );
  }
}
