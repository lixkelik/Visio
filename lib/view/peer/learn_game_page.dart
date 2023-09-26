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
        title: const Text('TacTeacher'),
        backgroundColor: appOrange,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 15),
          child: Column(
            children: [
              Text(
                "What do you want to\nlearn today?",
                style: styleB25,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
        
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: appOrange,
                  borderRadius: BorderRadius.circular(10),
                ),
        
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
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
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please ask a question!'),
                                backgroundColor: Colors.red,
                              )
                            );
                          }else{
                            completionFun();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: appYellow,
                        ),
                      
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            'Ask!',
                            style: styleB20,
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
              
              : Text(
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
      print(responseText);
    });
  }
}