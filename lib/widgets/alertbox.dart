import 'package:flutter/material.dart';
import 'package:quiz_app/data/constants.dart';


class ResultBox extends StatelessWidget {
  ResultBox({Key? key,
    required this.QuestionLength,
    required this.result,
  required this.onPressed}) : super(key: key);
final int result;
final int QuestionLength;
final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: backgroundColor,


      content: Padding(padding: EdgeInsets.all(60),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Text('Result',style: TextStyle(
          color: netural,
          fontSize: 22,
        ),),
          SizedBox(height: 20,),
          CircleAvatar(
            child:Text('$result/$QuestionLength',
            style: TextStyle(fontSize: 24),) ,
            radius: 70,
            backgroundColor: result == QuestionLength/2 ? Colors.yellow:
            result < QuestionLength/2 ?
            incorrect:correct

          ),
          SizedBox(height: 20,),
          Text(
              result == QuestionLength/2 ? 'Almost there Better Luck ':
              result < QuestionLength/2 ?
              'Try Again':'Nice job!',style: TextStyle(color:netural ),
          ),
          SizedBox(height: 20,),
       GestureDetector( onTap: onPressed,
           child: Text('Start over',style: TextStyle(fontSize: 18,
           color: netural),))

      ],),),
    );
  }
}
