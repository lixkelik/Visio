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

Future<int> getUserRole() async{
  String uid = await getUid();
  DocumentSnapshot doc = await db.collection('users').doc(uid).get();
  return doc['role'];
}

Future<int> getUserCoin() async{
  String uid = await getUid();
  DocumentSnapshot doc = await db.collection('users').doc(uid).get();
  return doc['coin'];
}

Future<void> deductCoin(int deduct) async{
  String uid = await getUid();
  int newCoin = await getUserCoin() - deduct;
  await db.collection('users').doc(uid).update({'coin': newCoin});
}

Future<void> updateCoin(int newCoin) async {
  String uid = await getUid();
  await db.collection('users').doc(uid).update({'coin': newCoin});
}

Future<void> registerUser(String email, String password, String name, int role) async{
  await auth.createUserWithEmailAndPassword(email: email.trim(), password: password.trim());
  String uid = auth.currentUser!.uid;
  db.collection('users').doc(uid).set({
    'name': name.trim(),
    'role': role,
    'email': email.trim(),
    'password': password.trim(),
    'coin': 5
  }).catchError(
    (error) {
      
    }
  );
}
