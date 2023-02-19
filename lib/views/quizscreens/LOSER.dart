import 'package:flutter/material.dart';
import 'package:quiz_app/views/quizscreens/profile.dart';
import 'package:quiz_app/views/quizscreens/questionui.dart';

class Loser extends StatelessWidget {
  Loser({Key? key, required this.winmoney, required this.correctAnswer,})
      : super(key: key);

  int winmoney;
 // String QuidId;

  String correctAnswer;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: NetworkImage(
            'https://www.hindustantimes.com/rf/image_size_960x540/HT/p2/2020/09/09/Pictures/_6f2d13e6-f28a-11ea-8bce-519453830254.jpg',
          ),
          fit: BoxFit.fill,
          opacity: 0.5,
        )),
        child: Scaffold(
          floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton:
              ElevatedButton(onPressed: () {}, child: Text('Retry')),
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Oh SORYY !',
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  'Your Answer is InCorrect ',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                Text(
                  'The Correct answer is: ${correctAnswer} ',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                Text(
                  'You Won ',
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
                Text(
                  'Rs ${winmoney == 2500 ? 0 : winmoney}',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
                Icon(
                  Icons.error_outline,
                  size: 40,
                  color: Colors.white,
                ),
                ElevatedButton(
                    onPressed: () {
                    //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>QuestionScreen(
                    //       QuizId:QuidId, questionmoney:winmoney*2)));
                    // },
                       Navigator.pop(context);},
                    child: Text('Go To Rewards'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
