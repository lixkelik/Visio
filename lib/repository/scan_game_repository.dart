import 'dart:io';

import '../constant/firebase_constant.dart';
import '../factory/game_factory.dart';

Future<bool> findGameDoc(String gameId) async {
  DocumentSnapshot documentSnapshot = await db.collection('games').doc(gameId).get();
  if (documentSnapshot.exists) {
    return true;
  }
  return false;
}

Future<List<String>> uploadImage(Game gameObj) async {
  List<String> downloadUrls = [];
  Reference ref = storage.ref('gamePhoto').child(gameObj.code);
  for (int i = 0; i < gameObj.obj.length; i++) {
    final File imageFile = File(gameObj.obj[i].image);
    final fileName = '${gameObj.code}$i.jpg';

    final Reference reference = ref.child(fileName);

    final UploadTask uploadTask = reference.putFile(imageFile);
    final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});

    final downloadUrl = await taskSnapshot.ref.getDownloadURL();

    downloadUrls.add(downloadUrl);
  }
  return downloadUrls;
}

Future<List<Game>> getGameCollection(String userId) async {
  List<Game> gameList = [];
  QuerySnapshot querySnapshot = await db.collection('games').where('createdBy', isEqualTo: userId).get();

  for (var doc in querySnapshot.docs) {
    Game game = Game(
      code: doc['code'],
      createdBy: doc['createdBy'],
      createdTime: doc['createdTime'],
      colaboratorTime: doc['colaboratorTime'],
      place: doc['place'],
      playedBy: doc['playedBy'],
      isPlayed: doc['isPlayed'],
      colaboratorUid: doc['colaboratorUid'],
      obj: doc['obj'],
    );
    gameList.add(game);
  }
  return gameList;
}

Future<void> saveToFirestore(Game game) async {
  final gameRef = db.collection('games').doc(game.code);
  await gameRef.set(game.toMap());
}