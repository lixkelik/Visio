import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import "package:visio/constant/constant_builder.dart";
import 'package:visio/factory/response_model.dart';
import 'package:http/http.dart' as http;

class LearnGamePage extends StatefulWidget {
  const LearnGamePage({super.key});

  @override
  State<LearnGamePage> createState() => _LearnGamePageState();
}

class _LearnGamePageState extends State<LearnGamePage> {

  late final TextEditingController promptController = TextEditingController();
  String responseText = '';
  late ResponseModel _responseModel;

  @override
  void dispose() {
    super.dispose();
    promptController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Visio Teacher'),
        backgroundColor: appOrange,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
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
                        if(promptController.text.isEmpty){
                          showSnackBar('Please ask a question!', Colors.red, context);
                        }else{
                          completionFun();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: appOrange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        )
                      ),
                    
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          'Ask!',
                          style: styleWSB20,
                        )
                      ),
                    ),
                  ),
                ],
              ),
            ),
      
            const Divider(height: 20, thickness: 1, color: fontColor,),
      
            (responseText == "")
            ? const SizedBox()
            
            : const Text(
              "The answer is:",
              style: styleR15
            ),

            const SizedBox(height: 10,),
            Text(
              responseText,
              style: styleR20,
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }

  completionFun() async{
    setState(() => responseText = 'Loading');
    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${dotenv.env['token']}',
      },
      body: jsonEncode(
        {
          'model': 'gpt-3.5-turbo-instruct',
          'prompt': promptController.text,
          'max_tokens': 250,
          'temperature': 0,
          'top_p': 1,
        }
      )
    );
    setState(() {
      _responseModel = ResponseModel.fromJson(json.decode(response.body));
      responseText = _responseModel.choices[0].text;
      responseText = responseText.replaceAll('\n\n', '');
    });
  }
}