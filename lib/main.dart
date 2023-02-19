import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/services/localdb.dart';
import 'package:quiz_app/views/home.dart';
import 'package:quiz_app/views/quizscreens/questionui.dart';
import 'package:quiz_app/views/quizscreens/quiz_intro.dart';
import 'package:quiz_app/views/strtupscreens/loginscreen.dart';
import 'package:quiz_app/views/strtupscreens/splashscreen.dart';
import 'package:overlay_support/overlay_support.dart';

Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
 MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
 bool isLogin=false;

  void getLoggedInstate()async{
    await localDb.getUserId().then((value){
      setState((){
        isLogin=value.toString()!="null";
      });

    });

  }

 @override
 void initState(){
    super.initState();
    getLoggedInstate();

 }

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:isLogin? Home():LoginScreen(),
      ),

    );
  }
}

