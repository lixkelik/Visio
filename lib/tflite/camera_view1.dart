import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visio/tflite/scan_controller.dart';

class CameraViewScreen extends StatelessWidget {
  const CameraViewScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ScanController>(
        init: ScanController(),
        builder: (controller){
          return controller.isCameraInitialized.value 
            ? AspectRatio( aspectRatio: 480/720, child: CameraPreview(controller.cameraController)) 
            : const Center(child: Text("Loading camera, please wait!"),);
        },

      ),
    );
  }
}