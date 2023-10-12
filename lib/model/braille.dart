import 'package:visio/model/letter.dart';

class Braille {
  String title;
  String description;
  String imgPath;
  List<int> dots;

  List<Letter> letterList;

  Braille(
      {required this.title,
      required this.description,
      required this.imgPath,
      required this.dots,
      required this.letterList});
}
