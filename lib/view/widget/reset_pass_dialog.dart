import 'package:visio/constant/constant_builder.dart';

resetPassDialog(context, String message, bool error){
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
              (error) ? Image.asset(exitills, width: 60,)
                      : Image.asset(loveills, width: 60,),
              const SizedBox(height: 5),
              Text(
                (error) ? 'Oops!' : 'Success!', 
                style: styleB20,
              ),
              Text(message, style: styleR15, textAlign: TextAlign.center,),
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
                    child: const Text('Ok!'),
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
