import 'package:visio/constant/constant_builder.dart';
import 'package:visio/view/authentication/register_page.dart';
import 'package:visio/constant/firebase_constant.dart';
import 'package:visio/view/main_page.dart';

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
        final shouldExit = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Exit App'),
            content: const Text('Are you sure you want to exit?'),
            actions: [
              TextButton(
                  child: const Text('No'),
                  onPressed: () => Navigator.of(context).pop(false),
                ),
                TextButton(
                  child: const Text('Yes'),
                  onPressed: () => Navigator.of(context).pop(true),
                ),
            ],
          )
        );
        return shouldExit ?? false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _formKey,
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 120),
                  child: Image.asset(
                    appLogo,
                    width: 77,
                    height: 77,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: fontColor,
                    ),
                  )
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30, left: 38, right: 38),
                  child: TextFormField(
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
                ),
        
                Container(
                  margin: const EdgeInsets.only(top: 25, left: 38, right: 38),
                  child: TextFormField(
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
                    decoration: inputDec('Password', isPassword: true ,obscure: _obscure, togglePass:  (value) {setState(() {
                      _obscure = value;
                    });},),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 38, vertical: 15),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : login,
                              
                              style: ElevatedButton.styleFrom(
                                backgroundColor: appOrange,
                                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: _isLoading 
                                ? const CircularProgressIndicator()
                                :const Text(
                                  'Login',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  )
                                )
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 45),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const RegisterPage()));
                          },
                          child: RichText(
                            text: TextSpan(
                              text: 'Don\'t have an account?',
                              style: styleR15,
                              children: const [
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
                      ),
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

  void pushPage(){
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(builder: (context) => const MainPage())
      );
    }

  Future login() async{
    if(_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim()
        );
        
        pushPage();

      } on FirebaseAuthException catch (e) {
        String errorMessage = "An error occurred. Please try again later.";
        if (e.code == 'user-not-found') {
          errorMessage = 'No user found!';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'Wrong password provided for that user!';
        } else {
          errorMessage = 'An error occurred. Please try again later.';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }

    
  }

  

}