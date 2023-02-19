import 'package:flutter/material.dart';

import '../data/constants.dart';


class NextButton extends StatelessWidget {
 NextButton({Key? key,required this.nextQuestion}) : super(key: key);

  final VoidCallback nextQuestion;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
 onTap:nextQuestion,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: netural,
          borderRadius: BorderRadius.circular(10),

        ),
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Text('Next Question',textAlign:TextAlign.center,style: TextStyle(

        ),),

      ),
    );
  }
}
