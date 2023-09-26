import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:visio/constant/constant_builder.dart';
import 'package:visio/constant/firebase_constant.dart';
import 'package:visio/firebase_options.dart';
import 'package:visio/view/authentication/login_page.dart';
import 'package:visio/view/main_page.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await dotenv.load();
  await Future.delayed(const Duration(seconds: 2));
  FlutterNativeSplash.remove();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _HomePageState();
}

class _HomePageState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    User? user  = auth.currentUser;
    return MaterialApp(
      title: 'visio',
      theme: ThemeData(
        fontFamily: 'Poppins',
        navigationBarTheme:  NavigationBarThemeData(
          backgroundColor: white,
          indicatorColor: selectedNavBar,
          indicatorShape:  const CircleBorder(
            side: BorderSide(
              color: appOrange,
              width: 14,
              strokeAlign: BorderSide.strokeAlignCenter,
            )
          ),
          labelTextStyle: MaterialStateProperty.all(
              const TextStyle(
                color: lightGrey,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              )
            ), 
          iconTheme: MaterialStateProperty.all(
            const IconThemeData(
              size: 35,
              color: lightGrey,
            )
          ),
          height: 90,
        )
      ),
      
      home: (user != null)
            ? const MainPage()
            : const LoginPage()
    );
  }
}
