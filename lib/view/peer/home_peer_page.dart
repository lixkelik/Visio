import 'package:visio/constant/firebase_constant.dart';
import 'package:visio/factory/user_factory.dart';
import 'package:visio/repository/user_repository.dart';
import 'package:visio/view/peer/article_peer_page.dart';
import 'package:visio/constant/constant_builder.dart';

import '../widget/coins_widget.dart';

class HomePeerPage extends StatefulWidget {
  final Function(int) updateCurrentPageIndex;
  const HomePeerPage({super.key, required this.updateCurrentPageIndex});

  @override
  State<HomePeerPage> createState() => _HomePeerPageState();
}

class _HomePeerPageState extends State<HomePeerPage> {
  _HomePeerPageState();

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
      backgroundColor: lightPink,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              (user != null)
                ? Text(
                    "Howdy, ${user!.name}!",
                    style: const TextStyle(
                      fontSize: 20,
                      color: fontColor,
                      fontWeight: FontWeight.w500
                    ),
                    overflow: TextOverflow.ellipsis,
                  )
                : skeletonBox(140, 30),
              const Text(
                "Let’s be smart Together!",
                style: styleB25
              ),
              const SizedBox(height: 10),
              Image.asset(
                drinkCircleills,
                width: 180,
                height: 180
              ),
              
              const SizedBox(height: 15),
              showCoinsWidget(context, _getUserData, bgColor: white, btnBg: appOrange, user: user),
              const SizedBox(height: 15),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text('Badges gained',
                        style: styleB15),
                    const SizedBox(height: 10),
                    Container(
                      height: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: lightBlue
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: <Widget>[
                            (expTotal < 40)
                            ? const Text(
                              'You don\'t have any badges!'
                              , style: TextStyle(
                                color: Color.fromARGB(255, 131, 131, 131),
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
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 70,
                            decoration: BoxDecoration(
                                color: lightBlue,
                                borderRadius:
                                    BorderRadius.circular(30)),
                            child: Column(
                              mainAxisAlignment:
                                  MainAxisAlignment.center,
                              children: [
                                const Text('Total Games', style: styleR15),
                                const SizedBox(height: 5),
                                Text(
                                  '$gameTotal',
                                  style: styleB20
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            height: 70,
                            decoration: BoxDecoration(
                                color: lightBlue,
                                borderRadius:
                                    BorderRadius.circular(30)),
                            child: Column(
                              mainAxisAlignment:
                                  MainAxisAlignment.center,
                              children: [
                                const Text('XP Gained',
                                    style: styleR15),
                                const SizedBox(height: 5),
                                Text(
                                  '$expTotal',
                                  style: styleB20
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
              const SizedBox(height: 15),

              // game button
              InkWell(
                onTap: () {
                  widget.updateCurrentPageIndex(1);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(20),
                        child: const Text("Let's Play a\n Game!",
                            style: TextStyle(
                                fontSize: 25,
                                color: fontColor,
                                fontWeight: FontWeight.bold)),
                      ),
                      Expanded(
                          child: Image.asset(
                        coolills,
                        height: 90,
                      )),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // article button
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ArticlePeer()),
                  );
                },

                child: Container(
                  height: 285,
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(30),
                  ),

                  child: Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30)),
                            color: white),
                        padding: const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Today's fun article!",
                              style: styleB15,
                            ),
                            const SizedBox(height: 10),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                articleBg,
                                width: double.infinity,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text('What is an Airport ?',
                                style: styleB20),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(30),
                                  bottomRight: Radius.circular(30)),
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
              const SizedBox(height: 15,),
              Container(
                padding: const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 8),
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(30),

                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: lightBlue
                      ),
                      child: const Text(
                        "Visio supported by*",
                        style: TextStyle(
                          color: fontColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                    const SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(pertuniSponsor, height: 54,),
                        const SizedBox(width: 10,),
                        Image.asset(wbuSponsor, height:  54,),
                        const SizedBox(width: 10,),
                        Image.asset(mitranetraSponsor, height:  54,)
                      ],
                    ),
                    const SizedBox(height: 8,),
                    const Text(
                      "*not real, only for example purpose",
                      style: TextStyle(
                        color: lightGrey,
                        fontSize: 10,
                      )
                    )
                  ],
                ),
              ),
        
              // end page
              const SizedBox(height: 15)
            ],
          ),
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

  void _getUserData() async {
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
