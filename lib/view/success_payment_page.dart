import 'package:visio/constant/constant_builder.dart';

class SuccessPaymentPage extends StatelessWidget {
  const SuccessPaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGreen,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 70, bottom: 20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              width: 260,
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.verified_rounded,
                    color: Colors.green,
                  ),
                  SizedBox(width: 7,),
                  Text(
                    "Payment Success!",
                    style: styleSB20,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20,),
            Container(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 30, bottom: 20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                children: [
                  Image.asset(
                    kingills,
                    width: 189,
                    height: 210,
                  ),
                  const SizedBox(height: 15,),
                  const Text(
                    "Thank you!",
                    style: styleSB25,
                    textAlign: TextAlign.center,
                  ),
                  const Text(
                    "Your support to Visio\nwill be remembered!",
                    style: styleR20,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20,),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.popUntil(context, (route) => route.isFirst);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: appOrange,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text('Return',
                            style: styleWSB25)),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}