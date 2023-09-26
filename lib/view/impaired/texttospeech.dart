import 'package:flutter_tts/flutter_tts.dart';

FlutterTts flutterTts = FlutterTts();

double volume = 1;
double speechRate = 0.4;

void textToSpeech(String theObject) async{
  await flutterTts.setLanguage("en-US");
  await flutterTts.setVolume(volume);
  await flutterTts.setSpeechRate(speechRate);
  await flutterTts.setPitch(1);
  await flutterTts.speak(theObject);
  await flutterTts.setSilence(250);
}