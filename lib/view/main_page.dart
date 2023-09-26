import 'package:visio/constant/constant_builder.dart';
import 'package:visio/constant/firebase_constant.dart';
import 'package:visio/view/impaired/history_impaired_page.dart';
import 'package:visio/view/impaired/game_impaired_page.dart';
import 'package:visio/view/peer/choose_game_page.dart';
import 'package:visio/view/peer/history_peer_page.dart';
import 'package:visio/view/peer/home_peer_page.dart';
import 'package:visio/view/profile_page.dart';

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
  void initState(){
    getUserRole();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(userRoles != null){
      return WillPopScope(
        onWillPop: () async{
        final shouldExit = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Exit App'),
            content: const Text('Are you sure you want to exit?'),
            actions: [
              TextButton(
                  child: const Text('No'),
                  onPressed: () => Navigator.of(context).pop(false),
                ),
                TextButton(
                  child: const Text('Yes'),
                  onPressed: () => Navigator.of(context).pop(true),
                ),
            ],
          )
        );
        return shouldExit ?? false;
      },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          bottomNavigationBar: NavigationBar(
            animationDuration: const Duration(milliseconds: 1000),
            destinations:  <Widget> [
              (userRoles == 1) 
              ? const NavigationDestination(
                icon: Icon(Icons.explore_outlined),
                label: 'Explore',
              )
              : const NavigationDestination(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              const NavigationDestination(
                icon: Icon(Icons.gamepad_outlined),
                label: 'Game',
              ),
              const NavigationDestination(
                icon: Icon(Icons.access_time),
                label: 'History',
              ),
              const NavigationDestination(
                icon: Icon(Icons.account_circle_outlined),
                label: 'Profile',
              )
            ],
            onDestinationSelected: (int index) {
              setState(() {
                currentPageIndex = index;
              });
            },
            selectedIndex: currentPageIndex,
          ),
      
          body: <Widget>[
            (userRoles == 1)
            ? const ExplorePage()
            : HomePeerPage(updateCurrentPageIndex: updateCurrentPageIndex,),
            (userRoles == 1)
            ? const GameImpaired()
            : const ChooseGamePage(),
            (userRoles == 1)
            ? HistoryImpairedPage(auth.currentUser!.uid)
            : HistoryPeerPage(auth.currentUser!.uid),
            ProfilePage(userRoles!),
            //add page here
          ][currentPageIndex],
        ),
      );
    } else {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: Image(
                  image: AssetImage(
                    welcome
                  ),
                  width: 150,
                  height: 150,
                ),
              ),
              const SizedBox(height: 10,),
              Center(
                child: Text('Welcome to Tac Tile!',
                  style: styleSB25)
              ),
            ],
          ),
        )
      );
    }
  }

  Future<void> getUserRole() async{
    if(auth.currentUser != null){
      QuerySnapshot snapshot = await db.collection('users').where('uid', isEqualTo: auth.currentUser!.uid).get();
      for (var doc in snapshot.docs) {
        setState(() {
          userRoles = int.parse(doc['role'].toString());
        });
      }
    }
  }

  void updateCurrentPageIndex(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }
}