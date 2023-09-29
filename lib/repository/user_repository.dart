import 'package:visio/constant/firebase_constant.dart';
import 'package:visio/factory/user_factory.dart';

Future<String> getUid() async {
  String uid;
  uid = auth.currentUser!.uid;
  return uid;
}

Future<UserVisio> getUserData() async {
  String uid = await getUid();
  DocumentSnapshot doc = await db.collection('users').doc(uid).get();

  UserVisio user = UserVisio(
    uid: uid,
    name: doc['name'].toString(),
    email: doc['email'].toString(),
    role: doc['role'],
    coin: doc['coin'],
  );
  return user;
}