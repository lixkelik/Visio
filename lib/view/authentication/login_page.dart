import 'package:visio/constant/constant_builder.dart';
import 'package:visio/view/authentication/register_page.dart';
import 'package:visio/constant/firebase_constant.dart';
import 'package:visio/view/main_page.dart';
import 'package:visio/view/widget/exit_dialog.dart';

import 'auth_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  bool _obscure = true;

  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
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
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _formKey,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: pagePadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 60,),
                Image.asset(
                  helloills,
                  width: 134,
                  height: 123,
                ),
                const SizedBox(height: 10,),
                const Text(
                  'Hello!',
                  style: styleB35
                ),
                const Text(
                  'Welcome to Visio!',
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
                        decoration: inputDec('Password', hint: "*******", isPassword: true ,obscure: _obscure, togglePass:  (value) {setState(() {
                          _obscure = value;
                        });},),
                      ),
                    ],
                  ),
                ),
                
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : login,
                          
                          style: ElevatedButton.styleFrom(
                            backgroundColor: appOrange,
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: _isLoading 
                            ? const CircularProgressIndicator()
                            :const Text(
                              'Login',
                              style: styleWSB25
                            )
                        ),
                      ),
                      const SizedBox(height: 10,),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const RegisterPage()));
                        },
                        child: RichText(
                          text: const TextSpan(
                            text: 'Don\'t have an account?',
                            style: styleR15,
                            children: [
                              TextSpan(
                                text: ' Register here',
                                style: TextStyle(
                                  color: appOrange,
                                  fontWeight: FontWeight.w600
                                ),
                              )
                            ]
                          ),
                        ),
                      ),
                      const SizedBox(height: 25,)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  popAndPushPage(){
    Navigator.pushAndRemoveUntil(
      context, 
      MaterialPageRoute(builder: (context) => const MainPage()),
      (route) => false
    );
  }

  Future login() async{
    if(_formKey.currentState!.validate()) {
      if(mounted){
        setState(() {
          _isLoading = true;
        });
      }
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim()
        );
        
        popAndPushPage();

      } on FirebaseAuthException catch (e) {
        String errorMessage = "An error occurred. Please try again later.";
        if (e.code == 'user-not-found') {
          errorMessage = 'No user found!';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'Wrong password provided for that user!';
        } else {
          errorMessage = 'An error occurred. Please try again later.';
        }
        showSnackBar(errorMessage, Colors.red, context);
        
      } finally {
        if(mounted){
          setState(() {
            _isLoading = false;
          });
        }
      }
    }

    
  }

  

}