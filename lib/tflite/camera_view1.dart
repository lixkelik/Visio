import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:visio/constant/constant_builder.dart';
import 'package:visio/tflite/scan_controller.dart';

class CameraViewScreen extends StatelessWidget {
  const CameraViewScreen({super.key, required this.setLabel});
  final Function setLabel;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ScanController>(
        init: ScanController(),
        builder: (controller){
          if(controller.isCameraInitialized.value){
            //setLabel(controller.label);
            return Stack(
              children: [
                AspectRatio(
                  aspectRatio: 9/16, 
                  child: CameraPreview(controller.cameraController)
                ),
                (controller.y == null || controller.x == null || controller.w == null ) ? const SizedBox()
                : Positioned(
                  top: controller.y * 720,
                  right: controller.x * 480,
                  child: Container(
                    width: controller.w * 100 * context.width / 100,
                    height: controller.h * 100 * context.height / 100,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(3)),
                      border: Border.all(color: appOrange, width: 3),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          color: white,
                          child: Text(controller.label)
                        )
                      ],
                    ),
                  ),
                )
              ],
            );
          } else{
            return const Center(child: Text("Loading camera, please wait!"),);
          }
        },

      ),
    );
  }
}