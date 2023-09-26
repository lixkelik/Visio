import 'package:visio/constant/constant_builder.dart';
import 'package:visio/constant/firebase_constant.dart';
import 'package:visio/view/authentication/login_page.dart';
import 'package:visio/view/main_page.dart';

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

  bool _isLoading = false;
  bool _obscure = true;
  String dropdownValue = 'Im Visually Impaired';

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
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: SizedBox(
              width: double.infinity,
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
                      'Register',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: fontColor,
                      ),
                    )
                  ),
        
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: appYellow.withOpacity(0.3)
                    ),
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 30, left: 38, right: 38),
                    child: DropdownButtonFormField<String>(
                      value: dropdownValue,
                      dropdownColor: white,
                      borderRadius: BorderRadius.circular(10),
                      alignment: Alignment.center,
                      decoration: InputDecoration(
                        filled: false,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: appOrange, width: 3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: appOrange, width: 3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: <String>['Im Visually Impaired', 'Im Sighted Peer']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value, 
                            style: const TextStyle(color: fontColor, fontWeight: FontWeight.w600),
                          )
                        );
                        
                      }).toList(),
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 30,
                    ),
                  ),
        
                  Container(
                    margin: const EdgeInsets.only(top: 30, left: 38, right: 38),
                    child: TextFormField(
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
        
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 38, vertical: 15),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : register,
                              
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
                                  'Register',
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
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                          },
                          child: RichText(
                            text: TextSpan(
                              text: 'Already have an account? ',
                              style: styleR15,
                              children: const [
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
                      ),
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

  Future register() async{
    //ROLES 1 = VISUALLY IMPAIRED, 2 = SIGHTED PEER
    int role = 1;
    if(_formKey.currentState!.validate()){
      setState(() {
        _isLoading = true;
      });
    }
    try{
      await auth.createUserWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text.trim());
      
      if(dropdownValue == 'Im Visually Impaired'){
        role = 1;
      }else{
        role = 2;
      }

      db.collection('users').add({
        'uid': auth.currentUser!.uid,
        'name': nameController.text.trim(),
        'role': role,
        'email': emailController.text.trim(),
        'password': passwordController.text.trim(),
      }).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Account created succesfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }).catchError(
        (error) {
          
        }
      );
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(builder: (context) => const MainPage())
      );
    } on FirebaseAuthException catch(e){
      String errorMessage = "An error occurred. Please try again later.";
      if (e.code == 'weak-password') {
        errorMessage = "The password provided is too weak.";
      } else if (e.code == 'email-already-in-use') {
        errorMessage = "The account already exists for that email.";
      } else if (e.code == 'invalid-email') {
        errorMessage = "The email address is invalid.";
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    }finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}