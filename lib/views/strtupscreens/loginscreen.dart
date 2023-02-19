
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:quiz_app/services/auth.dart';
import 'package:quiz_app/views/home.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(

      appBar: AppBar(
        title: Text('LOGIN SCREEN'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding:EdgeInsets.symmetric(horizontal: size.height*.02),
              child: Image.asset('assets/images/gat.jpg', ),

            ),
            SizedBox(
              height: size.height*.1,
            ),

            Text('Welcome \n To Test Prepration App',textAlign: TextAlign.center,
            style: TextStyle(
           fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue
            ),),
            SizedBox(
              height: size.height*.05,
            ),
            SignInButton(Buttons.GoogleDark, onPressed: ()async{

                await signInWithGoogle();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Home()));




            }),

            SizedBox(
              height: size.height*.05,
            ),
            Text('By continue our terms and conditions'),


          ],
        ),
      ),
    );
  }
}
