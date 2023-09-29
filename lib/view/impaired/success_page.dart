import 'dart:io';

import 'package:visio/constant/constant_builder.dart';
import 'package:visio/factory/game_factory.dart';
import 'package:visio/view/impaired/texttospeech.dart';

class SuccessPage extends StatefulWidget {
  final Game gameObj;
  const SuccessPage(this.gameObj, {super.key});

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {

  @override
  void initState() {
    pageSpeech();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        return true;
      },
      child: Scaffold(
        backgroundColor: lightPink,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Good job!',
                style: styleB35
              ),
              Image.asset(
                kingCircleills,
                width: 160,
              ),
              const SizedBox(
                height: 8,
              ),
        
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                decoration: const BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "You have scanned\n5 objects!",
                      style: styleB20,
                    ),
                    SizedBox(
                      height: 190,
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        itemExtent: 35,
                        children: [
                          ListTile(
                            title: Text(
                              widget.gameObj.obj[0].objName,
                              style: const TextStyle(fontSize: 23),
                            ),
                            leading: const Icon(Icons.add_task),
                          ),
                          ListTile(
                            title: Text(
                              widget.gameObj.obj[1].objName,
                              style: const TextStyle(fontSize: 23),
                            ),
                            leading: const Icon(Icons.add_task),
                          ),
                          ListTile(
                            title: Text(
                              widget.gameObj.obj[2].objName,
                              style: const TextStyle(fontSize: 23),
                            ),
                            leading: const Icon(Icons.add_task),
                          ),
                          ListTile(
                            title: Text(
                              widget.gameObj.obj[3].objName,
                              style: const TextStyle(fontSize: 23),
                            ),
                            leading: const Icon(Icons.add_task),
                          ),
                          ListTile(
                            title: Text(
                              widget.gameObj.obj[4].objName,
                              style: const TextStyle(fontSize: 23),
                            ),
                            leading: const Icon(Icons.add_task),
                          ),
                        ]
                      ),
                    ),
                    const SizedBox(
                      width: double.infinity,
                      child: Text('Share with your friend!\nGive him this code below',
                          softWrap: true,
                          style: styleR20,
                          textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      height: 60,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Color(0xff666666),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          textToSpeech(widget.gameObj.code);
                        },
                        child: Center(
                          child: Text(widget.gameObj.code,
                              style: const TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                      )
                    ),
        
                  ],
                ),
              ),
              
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () async {
                        await deletePhoto();
                        popPage();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: appOrange,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text('Go Back',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void pageSpeech() {
    textToSpeech(
        'Congratulations! You finish the game, share the code with your friend. The code is ${widget.gameObj.code}');
  }

  Future<void> deletePhoto() async {
    for (int i = 0; i < 5; i++) {
      final fileOnDevice = File(widget.gameObj.obj[i].image);

      if (await fileOnDevice.exists()) {
        await fileOnDevice.delete();
      }
    }
  }

  popPage(){
    Navigator.popUntil(
      context,
      (route) => route.isFirst,
    );
  }
}
