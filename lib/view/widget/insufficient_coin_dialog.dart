import 'package:visio/constant/constant_builder.dart';

import '../buy_coins_page.dart';

showInsufficientCoinDialog(context){
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
              const Text('Not enough coins!', style: styleB20,),
              const Text('Do you want to get or buy some coins?', style: styleR15, textAlign: TextAlign.center,),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('No'),
                  ),

                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context, 
                        MaterialPageRoute(
                          builder: (context) => const BuyCoinsPage()
                        )
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: appOrange,
                    ),
                    child: const Text('Yes!', style: TextStyle(color: white)),
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
