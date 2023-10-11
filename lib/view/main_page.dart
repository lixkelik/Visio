import 'package:visio/constant/constant_builder.dart';
import 'package:visio/constant/firebase_constant.dart';
import 'package:visio/view/impaired/history_impaired_page.dart';
import 'package:visio/view/impaired/game_impaired_page.dart';
import 'package:visio/view/impaired/select_game_page.dart';
import 'package:visio/view/impaired/texttospeech.dart';
import 'package:visio/view/peer/choose_game_page.dart';
import 'package:visio/view/peer/history_peer_page.dart';
import 'package:visio/view/peer/home_peer_page.dart';
import 'package:visio/view/profile_page.dart';
import 'package:visio/view/widget/exit_dialog.dart';

import '../repository/user_repository.dart';
import 'impaired/explore_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  //ROLES DARI DATABASE, 1 = VISUALLY IMPAIRED, 2 = SIGHTED PEER
  int? userRoles;
  int currentPageIndex = 0;

  @override
  void initState() {
    getRole();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (userRoles != null) {
      return WillPopScope(
          onWillPop: () async {
            final shouldExit = await showExitDialog(context);
            return shouldExit ?? false;
          },
          child: Scaffold(
              resizeToAvoidBottomInset: false,
              bottomNavigationBar: BottomNavigationBar(
                elevation: 20,
                currentIndex: currentPageIndex,
                onTap: _onItemTapped,
                iconSize: 40,
                selectedItemColor: appOrange,
                unselectedItemColor: lightGrey,
                showUnselectedLabels: true,
                enableFeedback: true,
                type: BottomNavigationBarType.fixed,
                items: [
                  (userRoles == 1)
                      ? const BottomNavigationBarItem(
                          icon: Icon(
                            Icons.explore_outlined,
                          ),
                          label: 'Explore',
                        )
                      : const BottomNavigationBarItem(
                          icon: Icon(Icons.home_outlined),
                          label: 'Home',
                        ),
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.gamepad_outlined),
                    label: 'Game',
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.access_time),
                    label: 'History',
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle_outlined),
                    label: 'Profile',
                  )
                ],
              ),
              body: _pageItem.elementAt(currentPageIndex)));
    } else {
      return const Scaffold(
          backgroundColor: lightPink,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image(
                    image: AssetImage(
                      helloills,
                    ),
                    width: 270,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(child: Text('Welcome to Visio!', style: styleSB25)),
              ],
            ),
          ));
    }
  }

  void getRole() async {
    userRoles = await getUserRole();
    setState(() {});
  }

  void updateCurrentPageIndex(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  List<Widget> get _pageItem {
    return <Widget>[
      (userRoles == 1)
          ? const ExplorePage()
          : HomePeerPage(
              updateCurrentPageIndex: updateCurrentPageIndex,
            ),
      (userRoles == 1) ? const SelectGamePage() : const ChooseGamePage(),
      (userRoles == 1)
          ? HistoryImpairedPage(auth.currentUser!.uid)
          : HistoryPeerPage(auth.currentUser!.uid),
      ProfilePage(userRoles!),
    ];
  }

  void _onItemTapped(int index) {
    stopVoice();
    setState(() {
      currentPageIndex = index;
    });
  }

  stopVoice() async {
    await flutterTts.stop();
  }
}
