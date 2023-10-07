import 'package:visio/constant/constant_builder.dart';
import 'package:visio/view/widget/ads_dialog.dart';
import '../repository/user_repository.dart';
import 'success_payment_page.dart';
import 'widget/coin_amount_card.dart';

class BuyCoinsPage extends StatefulWidget {
  const BuyCoinsPage({super.key});

  @override
  State<BuyCoinsPage> createState() => _BuyCoinsPageState();
}

class _BuyCoinsPageState extends State<BuyCoinsPage> {
  int? coins;
  int amountIndex = 0;
  String totalPrice = "0,00";
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    getCoin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: Container(
          margin: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: appOrange.withOpacity(0.7),
            shape: BoxShape.circle
          ),
          child: IconButton(
            onPressed: (() => Navigator.pop(context)), 
            icon: const Icon(Icons.arrow_back),
            tooltip: MaterialLocalizations.of(context).backButtonTooltip,
            splashRadius: 24,
            color: white,
            padding: EdgeInsets.zero,
            alignment: Alignment.center,
            iconSize: 24,
            enableFeedback: true,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Topup Coins",
              style: styleB25,
            ),
            const SizedBox(height: 10,),
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: white,
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                border: Border.all(
                  color: lightPurple,
                  width: 10
                )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(coinLogo, width: 39),
                  const SizedBox(width: 5,),
                  (coins == null) 
                  ? skeletonBox(40, 30) 
                  : Text(
                      coins.toString(),
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
            const SizedBox(height: 10,),
            ElevatedButton(
              onPressed: () {
                if(coins != null){
                  adsDialog(context, coins!);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: appOrange,
                padding: const EdgeInsets.all(15),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: const TextSpan(
                          text: "Not allowed to spend money?",
                            style: TextStyle(
                            fontSize: 12,
                            color: white
                          ),
                          children: [
                            TextSpan(
                              text: "Don’t worry!",
                              style: TextStyle(
                              fontSize: 12,
                              color: white,
                              fontWeight: FontWeight.w600
                            ),
                            )
                          ]
                        )
                      ),
                      const SizedBox(height: 8,),
            
                      const Text(
                        "Tap here to watch Ads",
                        style: TextStyle(
                          fontSize: 16,
                          color: white,
                        ),
                      ),
                      const Text(
                        "AND GET FREE COINS!",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xffFBFF3E),
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 5,),
                  Expanded(child: Image.asset(drinkCircleills)),
                ],
              ),
            ),
            const SizedBox(height: 15,),
            const Text(
              "Or buy with real money",
              style: styleB20,
            ),
            const SizedBox(height: 5,),
            coinAmountCard(changeIdx, setTotalPrice, amountIndex, 1, 10, "10.000,00"),
            const SizedBox(height: 5,),
            coinAmountCard(changeIdx, setTotalPrice, amountIndex, 2, 18, "18.000,00", bonus: 2),
            const SizedBox(height: 5,),
            coinAmountCard(changeIdx, setTotalPrice, amountIndex, 3, 25, "25.000,00", bonus: 5),
            
            const SizedBox(height: 15,),
            Text(
              "Total IDR $totalPrice",
              style: styleB20,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    if(_isLoading == true || coins == null){
                      null;
                    }else{
                      buyCoins();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: (_isLoading == true || coins == null) ? Colors.grey : appOrange,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: (_isLoading == true)
                  ? const CircularProgressIndicator()
                  : const Text(
                      'Pay!',
                      style: styleWSB25)
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void getCoin() async {
    coins = await getUserCoin();
    if(mounted){
      setState(() {});
    }
  }

  void setTotalPrice(String price){
    if(mounted){
      setState(() {
        totalPrice = price;
      });
    }
  }

  void changeIdx(int index){
    if(mounted) {
      setState(() {
        amountIndex = index;
      });
    }
  }

  void buyCoins() async {
    if(mounted){
      setState(() {
        _isLoading = true;
      });
    }
    if(amountIndex > 0 && amountIndex < 4){
      if(amountIndex == 1){
        coins = coins! + 10;
        await updateCoin(coins!);
      }else if(amountIndex == 2){
        coins = coins! + 18;
        await updateCoin(coins!);
      }else if(amountIndex == 3){
        coins = coins! + 25;
        await updateCoin(coins!);
      }
      pushPage();
    }else{
      showSnackBar("Please select coin amount first!", Colors.red, context);
    }
    if(mounted){
      setState(() {
        _isLoading = false;
      });
    }
  }

  void pushPage(){
    Navigator.pushReplacement(
      context, 
      MaterialPageRoute(
        builder: (context) => const SuccessPaymentPage()
      )
    );
  }
}