import 'package:visio/constant/firebase_constant.dart';
import 'package:visio/factory/user_factory.dart';
import 'package:visio/view/peer/article_peer_page.dart';
import 'package:visio/view/repository/firestore_repository.dart';
import 'package:visio/constant/constant_builder.dart';

class HomePeerPage extends StatefulWidget {
  final Function(int) updateCurrentPageIndex;
  const HomePeerPage({super.key, required this.updateCurrentPageIndex});

  @override
  State<HomePeerPage> createState() =>
      _HomePeerPageState(updateCurrentPageIndex);
}

class _HomePeerPageState extends State<HomePeerPage> {
  final Function(int) updateCurrentPageIndex;
  _HomePeerPageState(this.updateCurrentPageIndex);

  String uid = '';
  UserVisio? user;
  int gameTotal = 0;
  int expTotal = 0;

  @override
  void initState() {
    _getUid();
    _getUserData();
    _getUserPlayedGames();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            // profile picture and name
            Container(
              width: 93,
              height: 93,
              margin: const EdgeInsets.only(right: 12),
              child: const Image(image: AssetImage(profilePic)),
            ),
            const SizedBox(
              height: 10,
            ),
            (user != null)
                ? Text(
                    "Howdy, ${user!.name}!",
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  )
                : skeletonBox(140, 30),
            const SizedBox(height: 20),
            // xp bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: appOrange,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text('Badges gained',
                        style: TextStyle(
                            fontSize: 16,
                            color: white,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Container(
                      height: 55,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: white),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: <Widget>[
                            (expTotal < 40)
                            ? const Text(
                              'You don\'t have any badges!'
                              , style: TextStyle(
                                color: Colors.grey,
                                fontStyle: FontStyle.italic
                              ))
                            : const SizedBox(),
                            (expTotal >= 40)
                            ? const Tooltip(
                                triggerMode: TooltipTriggerMode.tap,
                                preferBelow: false,
                                message: 'Achieved by getting 40 XP',
                                child: Image(
                                    image: AssetImage(badge1), fit: BoxFit.contain),
                              )
                            : const SizedBox(),
                            const SizedBox(width: 10),
                            (expTotal >= 80)
                            ? const Tooltip(
                                triggerMode: TooltipTriggerMode.tap,
                                preferBelow: false,
                                message: 'Achieved by getting 80 XP',
                                child: Image(
                                    image: AssetImage(badge2), fit: BoxFit.contain),
                              )
                            : const SizedBox(),
                            const SizedBox(width: 10),

                            (expTotal >= 120)
                            ? const Tooltip(
                                triggerMode: TooltipTriggerMode.tap,
                                preferBelow: false,
                                enableFeedback: true,
                                message: 'Achieved by getting 120 XP',
                                child: Image(
                                    image: AssetImage(badge3), fit: BoxFit.contain),
                              )
                            : const SizedBox(),
                            const SizedBox(width: 10),

                            (expTotal >= 300)
                            ? const Tooltip(
                                triggerMode: TooltipTriggerMode.tap,
                                preferBelow: false,
                                message: 'Achieved by getting 300 XP',
                                child: Image(
                                    image: AssetImage(badge4), fit: BoxFit.contain),
                              )
                            : const SizedBox(),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          // flex: 1,
                          child: Container(
                            height: 85,
                            decoration: BoxDecoration(
                                color: white,
                                borderRadius:
                                    BorderRadius.circular(10)),
                            child: Column(
                              mainAxisAlignment:
                                  MainAxisAlignment.center,
                              children: [
                                // SizedBox(height: 20),
                                Text('Total Games', style: styleR15),
                                const SizedBox(height: 10),
                                Text(
                                  '$gameTotal',
                                  style: styleB25
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          // flex: 1,
                          child: Container(
                            height: 85,
                            decoration: BoxDecoration(
                                color: white,
                                borderRadius:
                                    BorderRadius.circular(10)),
                            child: Column(
                              mainAxisAlignment:
                                  MainAxisAlignment.center,
                              children: [
                                Text('XP Gained',
                                    style: styleR15),
                                const SizedBox(height: 10),
                                Text(
                                  '$expTotal',
                                  style: styleB25
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // game button
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 40), // Set the left and right padding
              child: InkWell(
                onTap: () {
                  updateCurrentPageIndex(1);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: green,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(20),
                        child: const Text("Let's Play a\n Game!",
                            style: TextStyle(
                                fontSize: 25,
                                color: white,
                                fontWeight: FontWeight.bold)),
                      ),
                      Expanded(
                          child: Image.asset(
                        clickMe,
                        height: 110,
                      )),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // article button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ArticlePeer()),
                  );
                },
                // tampilannya
                child: Container(
                  height: 285,
                  decoration: BoxDecoration(
                    color: appYellow,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  // tulisan artikel dll
                  child: Column(
                    children: <Widget>[
                      Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                            color: appYellow),
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Today's fun article!",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: white,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                articleBg,
                                width: double.infinity,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text('What is an Airport ?',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: white)),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              color: appOrange),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text('Read More',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: white,
                                        fontWeight: FontWeight.bold)),
                                Icon(
                                  Icons.arrow_right,
                                  size: 50,
                                  color: white,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // end page
            const SizedBox(height: 50)
          ],
        ),
      ),
    );
  }

  Future<void> _getUid() async {
    String value = await getUid();
    if(mounted){
      setState(() {
        uid = value;
      });
    }
  }

  Future<void> _getUserData() async {
    UserVisio user = await getUserData();
    if(mounted){
      setState(() {
        this.user = user;
      });
    }
  }

  Future<void> _getUserPlayedGames() async {
    QuerySnapshot data = await db.collection('games').where('colaboratorUid', isEqualTo: auth.currentUser!.uid).get();
    if(mounted){
      setState(() {
        gameTotal = data.docs.length;
        expTotal = gameTotal * 20;
      });
    }
  }

}
