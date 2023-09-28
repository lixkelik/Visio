import 'package:visio/constant/constant_builder.dart';

ClipRRect skeletonBox(double width, double height){
  return ClipRRect(
    borderRadius: BorderRadius.circular(15),
    child: SizedBox(
      width: width,
      height: height,
      child: const LinearProgressIndicator(
        color: Color.fromARGB(255, 211, 211, 211),
        backgroundColor: Color.fromARGB(255, 232, 232, 232),
      )
    )
  );
  
}
