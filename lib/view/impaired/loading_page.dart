import 'package:visio/constant/constant_builder.dart';
import 'package:visio/constant/firebase_constant.dart';
import 'package:visio/factory/game_factory.dart';
import 'package:visio/view/impaired/success_page.dart';
import 'package:visio/view/impaired/texttospeech.dart';
import 'package:visio/view/repository/firestore_repository.dart';

import 'code_generator.dart';

class LoadingPage extends StatefulWidget {
  final Game gameObj;
  const LoadingPage(this.gameObj, {super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  late Game gameObj;

  @override
  void initState() {
    super.initState();
    gameObj = widget.gameObj;
    saveObj();
    pageSpeech();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: (gameObj.code == '')
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(color: appOrange, ),
                    SizedBox(height: 20),
                    Text(
                      'Uploading file please wait...',
                      style: styleB15,
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              )
            : SuccessPage(gameObj));
  }

  void pageSpeech() {
    textToSpeech('Please wait, we are uploading your file! We will let you know when it\'s finished');
  }

  Future<void> saveObj() async {
    String code;
    DocumentSnapshot<Object?> docSnapshot;

    do{
      code = await codeGenerator();
      DocumentReference docRef = db.collection('games').doc(code);
      docSnapshot = await docRef.get();
    }while(docSnapshot.exists);
    
    gameObj.code = code;

    gameObj.createdBy = auth.currentUser!.uid;

    List<String> downloadUrl = await uploadImage(gameObj);

    for (int i = 0; i < 5; i++) {
      gameObj.obj[i].image = downloadUrl[i];
    }

    saveToFirestore(gameObj);

    setState(() {});
  }
}
