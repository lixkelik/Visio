import 'package:visio/constant/constant_builder.dart';

showExitDialog(context){
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30)
        ),
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(exitills, width: 60,),
              const SizedBox(height: 5),
              const Text('Exit App!', style: styleB20,),
              const Text('Are you sure want to exit from the app ?', style: styleR15, textAlign: TextAlign.center,),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(10),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      )
                    ),
                    child: const Text('No'),
                  ),

                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(10),
                      backgroundColor: Colors.red,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      )
                    ),
                    child: const Text('Exit', style: TextStyle(color: white)),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
