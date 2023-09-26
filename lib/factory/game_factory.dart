import 'package:visio/constant/firebase_constant.dart';

class Game{
  String place;
  List<ItemObject> obj;
  String code;
  String createdBy;
  String playedBy;
  Timestamp createdTime;
  Timestamp colaboratorTime;
  bool isPlayed;
  String colaboratorUid;
  Game({required this.place, required this.obj, required this.code, required this.createdBy, required this.playedBy, required this.createdTime, required this.isPlayed, required this.colaboratorUid, required this.colaboratorTime});

  Map<String, dynamic> toMap() {
    return {
      'createdBy': createdBy,
      'createdTime': createdTime,
      'colaboratorTime': Timestamp.now(),
      'place': place,
      'obj': obj.map((o) => o.toMap()).toList(),
      'code': code,
      'playedBy': playedBy,
      'isPlayed': isPlayed,
      'colaboratorUid': colaboratorUid
    };
  }
}

class ItemObject{
  String image;
  String objName;
  String description;
  String colaboratorDesc;
  ItemObject({required this.image, required this.objName, required this.description, required this.colaboratorDesc});

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'objName': objName,
      'description': description,
      'colaboratorDesc': colaboratorDesc,
    };
  }
}