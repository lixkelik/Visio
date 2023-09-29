import 'package:visio/constant/constant_builder.dart';
import 'package:visio/view/buy_coins_page.dart';

import '../../factory/user_factory.dart';

showCoinsWidget(context, Function updateCoin, {required Color bgColor, required Color btnBg, UserVisio? user}){
  return Row(
    children: [
      Expanded(
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: const BorderRadius.all(Radius.circular(30)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(coinLogo, width: 39),
              const SizedBox(width: 10,),
              (user == null) 
              ? skeletonBox(40, 30) 
              : Text(
                  user.coin.toString(),
                  style: styleB25,
                ),
              const SizedBox(width: 10,),
              const Text(
                "Coins Left",
                style: styleR20,
              ),
            ],
          ),
        ),
      ),
      const SizedBox(width: 10,),
      ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const BuyCoinsPage())
          ).then((value){
            updateCoin();
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: btnBg,
          padding: const EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          fixedSize: const Size(82, 55),
          elevation: 0
        ),
        child: const Icon(Icons.add, color: white, size: 35),
      ),
    ],
  );
}