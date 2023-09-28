import 'package:visio/constant/constant_builder.dart';
import 'package:visio/constant/firebase_constant.dart';
import 'package:visio/view/authentication/login_page.dart';
import 'package:visio/factory/user_factory.dart';
import 'package:visio/view/repository/firestore_repository.dart';
import 'package:visio/view/impaired/texttospeech.dart';

class ProfilePage extends StatefulWidget {
  final int userRoles;
  const ProfilePage(this.userRoles, {super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  UserVisio? user;

  @override
  void initState() {
    if(widget.userRoles == 1){
      pageSpeech(); 
    }
    _getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: appOrange,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  Container(
                    width: 93,
                    height: 93,
                    margin: const EdgeInsets.only(right: 12),
                    child: const Image(image: AssetImage(profilePic)),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    (user != null)
                        ? Text(
                            user!.name,
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: white
                            ),
                            overflow: TextOverflow.ellipsis,
                          )
                        : Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          child: skeletonBox(140, 40)),
                    (user != null)
                        ? Text(
                            user!.email,
                            style: const TextStyle(
                              fontSize: 20,
                              color: white
                            ),
                            overflow: TextOverflow.ellipsis,
                          )
                        : skeletonBox(170, 20)
                  ])
                ],
              ),
            ),
            const SizedBox(height: 15,),
            const SizedBox(
              width: double.infinity,
              child: Text(
                'Preference',
                style: styleB30,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: lightBlue,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Container(
                  margin: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: double.infinity,
                        child: Text('Speech Reading Speed',
                            style: TextStyle(
                              fontSize: 20,
                              
                            )),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(children: [
                        Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            color: white,
                          ),
                          width: 75,
                          height: 50,
                          child: Center(
                            child: Text(speechRate.toStringAsFixed(2),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600
                                )),
                          ),
                        ),
                        Expanded(
                          child: Slider(
                              activeColor: appOrange,
                              max: 1,
                              min: 0.25,
                              value: speechRate,
                              onChanged: (double value) {
                                if(mounted){
                                  setState(() {
                                    speechRate = value;
                                  });
                                }
                              }),
                        )
                      ]),
                    ],
                  ),
                )),
            const SizedBox(height: 10,),
            Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: lightBlue,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Container(
                  margin: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: double.infinity,
                        child: Text('Speech Volume',
                            style: TextStyle(
                              fontSize: 20,
                            )),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(children: [
                        Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            color: white,
                          ),
                          width: 75,
                          height: 50,
                          child: Center(
                            child: Text(volume.toStringAsFixed(2),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600
                                )),
                          ),
                        ),
                        Expanded(
                          child: Slider(
                              activeColor: appOrange,
                              max: 2,
                              min: 0.1,
                              value: volume,
                              onChanged: (double value) {
                                if(mounted) {
                                  setState(() {
                                    volume = value;
                                  });
                                }
                              }),
                        )
                      ]),
                    ],
                  ),
                )),
            const SizedBox(height: 20,),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Colors.red,
                        width: 2,
                      )
                    ),
                    child: InkWell(
                      onTap: () {
                        showPopUp();
                      },
                      child: const Text(
                        'Logout',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.red,
                        )
                      )
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'All Rights Reserved\n2023 © Carbonara Team',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: lightGrey
                    )
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  showPopUp() {
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
                Image.asset(logoutills, width: 60,),
                const SizedBox(height: 5),
                const Text('Log Out!', style: styleB20,),
                const Text('Are you sure want to logout ?\nYou need to login again if you logout!', style: styleR15, textAlign: TextAlign.center,),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('No'),
                    ),

                    ElevatedButton(
                      onPressed: () {
                        signOut();
                        popAndPushPage();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: const Text('Logout', style: TextStyle(color: white)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  signOut() async{
    await auth.signOut();
  }

  Future<void> _getUserData() async {
    UserVisio user = await getUserData();
    if(mounted){
      setState(() {
        this.user = user;
      });
    }
  }

  popAndPushPage(){
    Navigator.pushAndRemoveUntil(
      context, 
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (route) => false
    );
  }

  void pageSpeech() {
    textToSpeech('You are at: Profile page.');
  }
}
