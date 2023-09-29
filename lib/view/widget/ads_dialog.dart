import 'package:visio/constant/constant_builder.dart';
import 'package:visio/repository/user_repository.dart';
import 'package:visio/view/success_payment_page.dart';

adsDialog(context, final int coin){
  popPage(){
    Navigator.pushReplacement(
      context, 
      MaterialPageRoute(
        builder: (context) => const SuccessPaymentPage()
      ),
    );
  }
  const int addCoin = 1;
  return showDialog(
    context: context,
    barrierDismissible: false,
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
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(adsPic)
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  await updateCoin(coin + addCoin);
                  popPage();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: appOrange,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  )
                ),
                child: const Text('Finish ads', style: TextStyle(color: white)),
              ),
            ],
          ),
        ),
      );
    },
  );
  
}
