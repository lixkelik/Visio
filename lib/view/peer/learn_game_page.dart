import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import "package:visio/constant/constant_builder.dart";
import 'package:visio/factory/response_model.dart';
import 'package:http/http.dart' as http;
import 'package:visio/view/buy_coins_page.dart';

import '../../repository/user_repository.dart';
import '../widget/insufficient_coin_dialog.dart';

class LearnGamePage extends StatefulWidget {
  const LearnGamePage({super.key});

  @override
  State<LearnGamePage> createState() => _LearnGamePageState();
}

class _LearnGamePageState extends State<LearnGamePage> {

  late final TextEditingController promptController = TextEditingController();
  String responseText = '';
  late ResponseModel _responseModel;
  int? coins;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    getCoins();
  }

  @override
  void dispose() {
    super.dispose();
    promptController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 10,),
                decoration: BoxDecoration(
                  color: lightPurple,
                  borderRadius: BorderRadius.circular(30),
                ),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => const BuyCoinsPage(),
                  )
                );
              },
              child: Row(
                children: [
                  Image.asset(coinLogo, width: 35,),
                  const SizedBox(width: 8,),
                  (coins == null) 
                  ? skeletonBox(40, 30)
                  : Text(
                      coins.toString(),
                      style: styleSB25,
                    ),
                ],
              ),
            ),
          ),
        ],
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
        padding: const EdgeInsets.only(left: 20, right: 20, top: 84, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "What do you want to\nlearn today?",
              style: styleB25,
            ),
            const Text(
              "Ask Visio teacher anything!\nFor example : What is laptop? or Explain me about airport!",
              style: styleR15,
            ),
            const SizedBox(height: 10),
        
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: lightPurple,
                borderRadius: BorderRadius.circular(30),
              ),
        
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextFormField(
                      controller: promptController,
                      style: const TextStyle(
                        color: fontColor,
                        fontSize: 20
                      ),
                      decoration: const InputDecoration(
                        hintText: "Ask Something",
                        border: InputBorder.none
                      ),
                    ),
                  ),
      
                  const SizedBox(height: 10,),
        
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: (){
                        if(_isLoading || coins == null || coins == 0){
                          if(coins == 0){
                            showInsufficientCoinDialog(context);
                          }else{
                            null;
                          }
                        }else{
                          if(promptController.text.isEmpty){
                            showSnackBar('Please ask a question!', Colors.red, context);
                          }else{
                            completionFun();
                          }
                        }
                      },
                      
                      style: ElevatedButton.styleFrom(
                        enableFeedback: true,
                        backgroundColor: (_isLoading || coins == null || coins == 0) ? Colors.grey : appOrange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        )
                      ),
                    
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: 
                        (_isLoading == false) 
                        ? const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Ask',
                              style: styleWSB20,
                            ),
                            SizedBox(width: 5,),
                            Text(
                              '(-1 Coin)'
                            ),
                          ],
                        )
                        : const CircularProgressIndicator()
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if(responseText == '') AnimatedOpacity(
              opacity: responseText.isEmpty ? 0.5 : 0.0,
              duration: const Duration(milliseconds: 700),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 1000),
                margin: const EdgeInsets.only(top: 30),
                alignment: Alignment.center,
                child: Image.asset(readills, height: 200,)
              ),
            ) 
            else AnimatedOpacity(
              opacity: responseText.isNotEmpty ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 1500),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 1000),
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: lightBlue
                ),
                child: Column(
                  children: [
                    const Text(
                      "The answer is:",
                      style: styleR15
                    ),
                    const SizedBox(height: 8,),
                    AnimatedOpacity(
                      opacity: responseText.isNotEmpty ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 1500),
                      child: Text(
                        responseText,
                        style: styleR20,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getCoins() async {
    coins = await getUserCoin();
    setState(() {});
  }

  completionFun() async{
    coins = await getUserCoin();
    if(coins! > 0){
      setState(() {
      _isLoading = true;
      });
      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${dotenv.env['token']}',
        },
        body: jsonEncode(
          {
            'model': 'gpt-3.5-turbo-instruct',
            'prompt': "${promptController.text} and Explain it like you explain to a child, and make sure it easy to understand for them, if the first sentences is not a question then just ignore this!",
            'max_tokens': 100,
            'temperature': 0,
            'top_p': 1,
          }
        )
      );
      await deductCoin(1);
      getCoins();
      setState(() {
        _isLoading = false;
        _responseModel = ResponseModel.fromJson(json.decode(response.body));
        responseText = _responseModel.choices[0].text;
        responseText = responseText.replaceAll('\n\n', '');
      });
    }else{

    }
  }
}