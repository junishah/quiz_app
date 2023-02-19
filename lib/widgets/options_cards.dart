import 'package:flutter/material.dart';
import 'package:quiz_app/data/constants.dart';

class OptionsCrad extends StatelessWidget {
 OptionsCrad({Key? key,required this.option,required this.color}) : super(key: key);
  final String option;

  final Color color;


  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,

      child: ListTile(

        title:
        Text(option,
          textAlign: TextAlign.center,style: TextStyle(
          fontSize: 18,
            color: color.red !=color.green ? netural:Colors.black

        ),),

      ),
    );
  }
}
