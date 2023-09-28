import 'package:visio/constant/constant_builder.dart';
import 'package:visio/constant/firebase_constant.dart';
import 'package:visio/view/main_page.dart';

class ChooseRolePage extends StatefulWidget {
  final String name;
  final String email;
  final String password;
  const ChooseRolePage({super.key, required this.name, required this.email, required this.password});

  @override
  State<ChooseRolePage> createState() => _ChooseRolePageState();
}

class _ChooseRolePageState extends State<ChooseRolePage> {

  int _selectedRoles = 0;
  bool _isLoading = false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightPurple,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: pagePadding),
        margin: const EdgeInsets.only(top: 50),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Hello, ${widget.name}",
              style: styleR20,
            ),
            const Text(
              "Choose your role!",
              style: styleSB30,
            ),
            Image.asset(
              balloonills,
              width: 176,
              height: 167,
            ),
            const SizedBox(height: 20,),
            InkWell(
              onTap: () {
                setState(() => _selectedRoles = 1);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: double.infinity,
                height: 136,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: (_selectedRoles == 1) ? appOrange : white,
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                ),
                child: Text(
                  "I'm Visually Impaired",
                  style: TextStyle(
                    color: (_selectedRoles == 1) ? white : fontColor,
                    fontSize: 25,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15,),
            InkWell(
              onTap: () {
                setState(() => _selectedRoles = 2);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: double.infinity,
                height: 136,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: (_selectedRoles == 2) ? appOrange : white,
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                ),
                child: Text(
                  "I'm Sighted Peer",
                  style: TextStyle(
                    color: (_selectedRoles == 2) ? white : fontColor,
                    fontSize: 25,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20,),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (_isLoading == true) ? null : register,
                
                style: ElevatedButton.styleFrom(
                  backgroundColor: appOrange,
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: _isLoading 
                  ? const CircularProgressIndicator()
                  : const Text(
                      'Register',
                      style: styleWSB25
                    )
              ),
            ),
          ]
        ),
      ),
    );
  }

  Future register() async{
    //ROLES 1 = VISUALLY IMPAIRED, 2 = SIGHTED PEER
    if(_selectedRoles == 1 || _selectedRoles == 2){
      try{
        await auth.createUserWithEmailAndPassword(email: widget.email.trim(), password: widget.password.trim());
      
        db.collection('users').add({
          'uid': auth.currentUser!.uid,
          'name': widget.name.trim(),
          'role': _selectedRoles,
          'email': widget.email.trim(),
          'password': widget.password.trim(),
        }).then((value) {
          showSnackBar('Account created succesfully!', Colors.green, context);
        }).catchError(
          (error) {
            
          }
        );
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
          context, 
          MaterialPageRoute(builder: (context) => const MainPage()),
          (route) => false
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
        showSnackBar(errorMessage, Colors.red, context);
        
      }finally {
        setState(() {
          _isLoading = false;
        });
      }
    }else{
      showSnackBar('Select a role first!', Colors.red, context);
    }
  }
}