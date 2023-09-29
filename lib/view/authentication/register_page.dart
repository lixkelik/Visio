import 'package:visio/constant/constant_builder.dart';
import 'package:visio/view/authentication/choose_role_page.dart';
import 'package:visio/view/authentication/login_page.dart';
import 'package:visio/view/widget/exit_dialog.dart';

import 'auth_widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _obscure = true;

  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        final shouldExit = await showExitDialog(context);
        return shouldExit ?? false;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: pagePadding),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40,),
                  Image.asset(
                    loveills,
                    width: 110,
                    height: 135,
                  ),

                  const SizedBox(height: 10,),
        
                  const Text(
                    'New Here?',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: fontColor,
                    ),
                  ),
                  const Text(
                    'Create an Account first!',
                    style: styleR20
                  ),
                  const SizedBox(height: 10,),

                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: const BoxDecoration(
                      color: lightBlue,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Name',
                          style: styleSB20
                        ),
                        const SizedBox(height: 5,),
                        TextFormField(
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if(value == null || value.isEmpty) {
                              return 'Please enter your name!';
                            } 
                            return null;
                          },
                          decoration: inputDec('Name', hint: 'ex: Natasha Atika'),
                        ),

                        const SizedBox(height: 18,),
              
                        const Text(
                          'Email',
                          style: styleSB20
                        ),
                        const SizedBox(height: 5,),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if(value == null || value.isEmpty) {
                              return 'Please enter your email';
                            } else if(!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)){
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                          decoration: inputDec('Email', hint: 'email@example.com'),
                        ),

                        const SizedBox(height: 18,),

                        const Text(
                          'Password',
                          style: styleSB20
                        ),
                        const SizedBox(height: 5,),
                        TextFormField(
                          controller: passwordController,
                          obscureText: _obscure,
                          validator: (value) {
                            if(value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }else if(value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                          decoration: inputDec('Password', hint: "*******",isPassword: true ,obscure: _obscure, togglePass:  (value) {setState(() {
                            _obscure = value;
                          });},),
                        ),
                        
                      ],
                    ),
                  ),

                  const SizedBox(height: 20,),
        
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: checkInput,
                          
                          style: ElevatedButton.styleFrom(
                            backgroundColor: appOrange,
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text(
                              'Register',
                              style: styleWSB25
                            )
                        ),
                      ),
                      const SizedBox(height: 10,),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                        },
                        child: RichText(
                          text: const TextSpan(
                            text: 'Already have an account? ',
                            style: styleR15,
                            children: [
                              TextSpan(
                                text: 'Login here',
                                style: TextStyle(
                                  color: appOrange,
                                  fontWeight: FontWeight.w600
                                ),
                              )
                            ]
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,)
                    ],
                  ),
                ],
              ),
            )
          ),
        ),
      ),
    );
  }

  void checkInput () {
    if(_formKey.currentState!.validate()){
      String name = nameController.text;
      String email = emailController.text;
      String password = passwordController.text;
      Navigator.push(
        context, 
        MaterialPageRoute(builder: 
          (context) => ChooseRolePage(name: name, email: email, password: password)
        ));
    }
  }
}