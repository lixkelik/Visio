import 'dart:math';

import 'package:visio/repository/scan_game_repository.dart';

Future<String> codeGenerator() async{
  const chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
  final random = Random.secure();
  String code = String.fromCharCodes(Iterable.generate(5, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
  while(await findGameDoc(code)){
    code = String.fromCharCodes(Iterable.generate(5, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
  }
  return code;
}