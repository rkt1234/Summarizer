import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:summarizer_app/firebase_options.dart';
import 'package:summarizer_app/provider/signin_provider.dart';
import 'package:summarizer_app/provider/signup_provider.dart';
import 'package:summarizer_app/provider/summary_provider.dart';
import 'package:summarizer_app/screens/home.dart';
import 'package:summarizer_app/screens/signup.dart';
import 'package:summarizer_app/services/firebase_services.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MultiProvider(
    providers: [
        ChangeNotifierProvider(create: (context) => SignupProvider()),
        ChangeNotifierProvider(create: (context) => SigninProvider()),
        ChangeNotifierProvider(create: (context) => SummaryProvider()),
      ],
    child: const MaterialApp(debugShowCheckedModeBanner: false, home: MyApp())));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});


  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var auth = FirebaseAuth.instance;
  var isLogin = false;

  checkiflogin() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null && mounted) {
        setState(() {
          isLogin = true;
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    checkiflogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child:  isLogin? Home():Signup(),

      );
  }
}
