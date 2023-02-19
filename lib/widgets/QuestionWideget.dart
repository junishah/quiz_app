import 'package:flutter/material.dart';
import 'package:quiz_app/data/constants.dart';


class QuestionWidget extends StatelessWidget {
  QuestionWidget({Key? key,required this.Question,required this.totalQuestion,required this.indexAction}) : super(key: key);
  final String Question;
  final int indexAction;
  final int totalQuestion;



  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Question ${indexAction+1}/$totalQuestion: $Question ',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color:netural
      ),),
    );
  }
}
