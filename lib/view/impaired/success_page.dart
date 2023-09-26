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
        body: Padding(
          padding: const EdgeInsets.only(left: 38, right: 38, top: 95),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Good job!',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: fontColor)),
              const Text('You have scanned and described 5 object!',
                  softWrap: true,
                  style: TextStyle(fontSize: 25, color: fontColor)),
              SizedBox(
                height: 220,
                child: ListView(
                    padding: const EdgeInsets.symmetric(vertical: 5),
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
                    ]),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text('Share with your friend!\nGive him this code below',
                  softWrap: true,
                  style: TextStyle(fontSize: 25, color: fontColor)),
              const SizedBox(
                height: 20,
              ),
              Container(
                  width: double.maxFinite,
                  height: 60,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
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
                              fontWeight: FontWeight.w600)),
                    ),
                  )),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 25),
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () async {
                          await deletePhoto();
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: appOrange,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text('Go Back',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ))),
                  ),
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
}
