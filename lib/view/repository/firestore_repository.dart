import 'dart:io';

import 'package:visio/constant/firebase_constant.dart';
import 'package:visio/factory/game_factory.dart';
import 'package:visio/factory/user_factory.dart';

Future<String> getUid() async {
  String uid;
  uid = auth.currentUser!.uid;
  return uid;
}

Future<UserVisio> getUserData() async {
  String uid = await getUid();
  QuerySnapshot querySnapshot =
      await db.collection('users').where('uid', isEqualTo: uid).get();

  UserVisio user = UserVisio(
    uid: uid,
    name: querySnapshot.docs[0]['name'].toString(),
    email: querySnapshot.docs[0]['email'].toString(),
    role: querySnapshot.docs[0]['role'],
  );
  return user;
}

Future<int> getUserRoles() async {
  String uid = await getUid();
  QuerySnapshot querySnapshot =
      await db.collection('users').where('uid', isEqualTo: uid).get();

  return querySnapshot.docs[0]['uid'];
}

Future<bool> findGameDoc(String gameId) async {
  DocumentSnapshot documentSnapshot =
      await db.collection('games').doc(gameId).get();
  if (documentSnapshot.exists) {
    return true;
  }
  return false;
}

Future<List<String>> uploadImage(Game gameObj) async {
  List<String> downloadUrls = [];
  Reference ref = storage.ref('gamePhoto').child(gameObj.code);
  // Create a unique filename for the image
  for (int i = 0; i < gameObj.obj.length; i++) {
    final File imageFile = File(gameObj.obj[i].image);
    final fileName = '${gameObj.code}$i.jpg';

    // Get a reference to the Firebase Cloud Storage bucket
    final Reference reference = ref.child(fileName);

    // Upload the file to the bucket
    final UploadTask uploadTask = reference.putFile(imageFile);
    final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});

    // Get the download URL for the file
    final downloadUrl = await taskSnapshot.ref.getDownloadURL();

    downloadUrls.add(downloadUrl);
  }
  return downloadUrls;
}

Future<List<Game>> getGameCollection(String userId) async {
  List<Game> gameList = [];
  QuerySnapshot querySnapshot =
      await db.collection('games').where('createdBy', isEqualTo: userId).get();

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
