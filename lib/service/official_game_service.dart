import 'package:visio/constant/constant_builder.dart';
import 'package:visio/constant/firebase_constant.dart';

class OfficialGameService {
  Future<void> addOfficialGame() async {
    // Get a reference to the collection
    CollectionReference collectionRef = getGame;
    // Add a document with dummy data to the collection
    await collectionRef.add({
      'createdBy': 'Carbonara',
      'createdTime': Timestamp.now(),
      'place': 'Classroom #01',
      'obj': [
        {
          'image': dummy_bag,
          'objName': 'Bag',
          'description': 'Plastic, sleek',
          'colaboratorDesc': '-',
        },
        {
          'image': dummy_book,
          'objName': 'Book',
          'description': 'Paper, can be used to read',
          'colaboratorDesc': '-',
        },
        {
          'image': dummy_chair,
          'objName': 'Chair',
          'description': 'Soft, wood, fabric, can be used to sit',
          'colaboratorDesc': '-',
        },
        {
          'image': dummy_glasses,
          'objName': 'Glasses',
          'description': 'flat, glass',
          'colaboratorDesc': '-',
        },
        {
          'image': dummy_pencil,
          'objName': 'Pencil',
          'description': 'wood, sharp, rough',
          'colaboratorDesc': '-',
        },
      ],
      'code': '-',
      'playedBy': '',
      'isPlayed': false,
      'colaboratorUid': '-'
    });
  }
}
