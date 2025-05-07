import 'package:book_stash/Auth/UI/login_screen.dart';
import 'package:book_stash/Auth/UI/signup_screen.dart';
import 'package:book_stash/firebase_options.dart';
import 'package:book_stash/pages/home.dart';
import 'package:book_stash/service/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
      ),
      // home: LoginScreen(),

      routes: {
        "/" : (context) => CheckUserBookStash(),
        "/login" : (context) => LoginScreen(),
        "/home" : (context) => Home(),
        "/signup": (context) => SignupScreen()
      },
    );
  }
}


class CheckUserBookStash extends StatefulWidget {
  const CheckUserBookStash({super.key});

  @override
  State<CheckUserBookStash> createState() => _CheckUserBookStashState();
}

class _CheckUserBookStashState extends State<CheckUserBookStash> {

  @override
  void initState() {
    AuthServiceHelper.isUserLoggedIn().then((value){
      if(value == true){
        Navigator.pushReplacementNamed(context, "/home");
      }else{
        Navigator.pushReplacementNamed(context, "/login");
      }
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}