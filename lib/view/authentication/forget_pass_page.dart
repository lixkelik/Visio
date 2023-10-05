import 'package:visio/constant/constant_builder.dart';
import 'package:visio/constant/firebase_constant.dart';
import 'package:visio/view/widget/reset_pass_dialog.dart';

import 'auth_widget.dart';

class ForgetPassPage extends StatefulWidget {
  const ForgetPassPage({super.key});

  @override
  State<ForgetPassPage> createState() => _ForgetPassPageState();
}

class _ForgetPassPageState extends State<ForgetPassPage> {

  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  bool _isValidate = false;
  
  @override
  void dispose(){
    super.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
        child: Form(
          autovalidateMode: (_isValidate) ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: pagePadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  sickills,
                  width: 145,
                ),
                const SizedBox(height: 10,),
                const Text(
                  'Ups!',
                  style: styleB35
                ),
                const Text(
                  'Sorry to hear that!\nFirst, i need your email so i can send a link to reset password to your email!',
                  style: styleR15,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10,),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: const BoxDecoration(
                    color: lightGreen,
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
                        controller: _emailController,
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
                    ],
                  ),
                ),

                const SizedBox(height: 25,),
                
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : resetPassword,
                    
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
                        'Send Link',
                        style: styleWSB25
                      )
                  ),
                ),
                
                const SizedBox(height: 25,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  resetPassword () async{
    if(_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try{
        await auth.sendPasswordResetEmail(email: _emailController.text.trim());
        resetPassDialog(context, "A reset password link\nhas sent to your email!", false);
        
      }on FirebaseAuthException catch(e){
        String errorMessage = "An error has occured! Please try again later";
        if (e.code == 'user-not-found') {
          errorMessage = 'User with that email is not found!';
        }
        resetPassDialog(context, errorMessage, true);
      } finally {
        setState(() {
          _isLoading = false;
          _isValidate = true;
        });
      }
      
    }else{
      setState(() {
        _isValidate = true;
      });
    }
    
  }
}