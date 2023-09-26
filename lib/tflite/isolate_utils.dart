import 'dart:io';
import 'dart:isolate';

import 'package:camera/camera.dart';
import 'package:image/image.dart' as image_lib;
import 'package:visio/tflite/classifier.dart';
import 'package:visio/tflite/image_utils.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

/// Manages separate Isolate instance for inference
class IsolateUtils {
  static const String debugName = "InferenceIsolate";

  late Isolate _isolate;
  final ReceivePort _receivePort = ReceivePort();
  late SendPort _sendPort;

  SendPort get sendPort => _sendPort;

  Future<void> start() async {
    _isolate = await Isolate.spawn<SendPort>(
      entryPoint,
      _receivePort.sendPort,
      debugName: debugName,
    );

    _sendPort = await _receivePort.first;
  }

  static void entryPoint(SendPort sendPort) async {
    final port = ReceivePort();
    sendPort.send(port.sendPort);

    await for (final IsolateData isolateData in port) {
      Classifier classifier = Classifier(
          interpreter:
              Interpreter.fromAddress(isolateData.interpreterAddress),
          labels: isolateData.labels);
      image_lib.Image? image = ImageUtils.convertCameraImage(isolateData.cameraImage);
      if (Platform.isAndroid) {
        image = image_lib.copyRotate(image!, 90);
      }
      Map<String, dynamic>? results = classifier.predict(image!);
      isolateData.responsePort.send(results);
    }
  }

  void dispose(){
    _isolate.kill();
    _receivePort.close();
  }
}

class IsolateData {
  CameraImage cameraImage;
  int interpreterAddress;
  List<String> labels;
  late SendPort responsePort;

  IsolateData(
    this.cameraImage,
    this.interpreterAddress,
    this.labels,
  );
}