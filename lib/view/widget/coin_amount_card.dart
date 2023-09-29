import '../../constant/constant_builder.dart';

coinAmountCard(Function changeIdx, Function setTotalPrice, int amountIndex, selectedIndex,int coinAmount, String price, {int? bonus}){
  return AnimatedContainer(
    duration: const Duration(milliseconds: 500),
    curve: Curves.easeInOut,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: (amountIndex != selectedIndex) ? lightBlue : green
      ),
    child: ElevatedButton(
      onPressed: (){
        changeIdx(selectedIndex);
        setTotalPrice(price);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        elevation: 0,
        shadowColor: Colors.transparent,
        padding: const EdgeInsets.all(10),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        )
      ),
      child: Row(
        children: [
          Image.asset(coinLogo, width: 50),
          const SizedBox(width: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "${coinAmount.toString()} Coins",
                    style: styleB20,
                  ),
                  if(bonus != null)
                  Text(
                    " + $bonus Free!",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red
                    ),
                  ),
                ],
              ),
              Text(
                "IDR $price",
                style: styleR20,
              )
            ],
          ),
        ],
      ),
    ),
  );
}