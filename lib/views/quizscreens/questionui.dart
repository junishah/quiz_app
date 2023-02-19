
import 'package:flutter/material.dart';
import 'package:quiz_app/services/firedb.dart';
import 'package:quiz_app/views/quizscreens/LOSER.dart';
import 'package:quiz_app/views/quizscreens/lifeline.dart';
import 'package:quiz_app/views/quizscreens/winscreen.dart';

import '../../model/newQuestionmodel.dart';
import '../../services/QuizQuestioncreator.dart';
import 'dart:async';



class QuestionScreen extends StatefulWidget {
  QuestionScreen({Key? key, required this.QuizId, required this.questionmoney})
      : super(key: key);

  String QuizId;
  int questionmoney;

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  QuestionModel questionModel = new QuestionModel();

  GenerateQuestion() async {
    await QuizQuestionCreator.generateQuestion(
        widget.QuizId, widget.questionmoney)
        .then((Questiondata) {
      setState(() {
        questionModel.question = Questiondata["question"];
        questionModel.correctAnswer = Questiondata["correctAnswer"];
        List options = [
          Questiondata["opt1"],
          Questiondata["opt2"],
          Questiondata["opt3"],
          Questiondata["opt4"],
        ];
        options.shuffle();
        questionModel.opt1 = options[0];
        questionModel.opt2 = options[1];
        questionModel.opt3 = options[2];
        questionModel.opt4 = options[3];
      });
    });
  }

  bool optionAlocked = false;
  bool optionBlocked = false;
  bool optionClocked = false;
  bool optionDlocked = false;
  int maximumSecond = 90;
  int Second = 90;
  Timer? timer; //timer object
  QuestionTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        Second--;
      });
      if (Second == 0) {
        timer?.cancel();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (_) => Loser(
                    winmoney:
                    widget.questionmoney == 5000 ? 0 : widget.questionmoney,
                    correctAnswer: questionModel.correctAnswer)));
      }
    });
  }



  // void CheckAnswerandUpdate(bool value){
  //   if(isAlredyselected){return;}
  //   else {
  //     if (value == true) {
  //       score++;}
  //     setState(() {
  //       ispressed = true;
  //       isAlredyselected=true;
  //     });
  //
  //     // else{
  //     //   setState(() {
  //     //     ispressed=true;
  //     //     isAlredyselected=true;
  //     //   });
  //     // }
  //   }
  //
  //
  // }
  // void StartOver(){
  //   setState(() {
  //     index=0;
  //     score=0;
  //     ispressed=false;
  //     isAlredyselected=false;
  //   });
  //   Navigator.pop(context);
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer?.cancel();
  }

  var correctscore = 0;
  var wrongscore = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GenerateQuestion();
    QuestionTimer();
  }

  @override
  Widget build(BuildContext context) {
    Future<bool?> showWarning(
        {required BuildContext context,
          required String title,
          required String content}) async =>
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(title),
              content: Text(content),
              actions: [
                ElevatedButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: Text("No!")),
                ElevatedButton(
                    onPressed: () async {
                      await FireDb.UpdateMoney(widget.questionmoney == 5000
                          ? 0
                          : widget.questionmoney ~/ 2);

                      Navigator.pop(context, true);
                    },
                    child: Text("Okay!")),
              ],
            ));
    final Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            'https://www.hindustantimes.com/rf/image_size_960x540/HT/p2/2020/09/09/Pictures/_6f2d13e6-f28a-11ea-8bce-519453830254.jpg',
          ),
          fit: BoxFit.fill,
          opacity: 0.5,
        ),
      ),
      child: WillPopScope(
        onWillPop: () async {
          final exitQuiz = await showWarning(
              context: context,
              title: "DO YOU WANT TO EXIT QUIZ ?",
              content:
              "You Will Get Rs.${widget.questionmoney == 5000 ? 0 : widget.questionmoney / 2} In Your Account.");
          return exitQuiz ?? false;
        },
        child: Scaffold(
          floatingActionButtonLocation:
          FloatingActionButtonLocation.centerFloat,
          floatingActionButton: ElevatedButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Do you want to quit the game  "),
                    content: Text(
                        "You will get money: ${widget.questionmoney == 5000 ? 0 : widget.questionmoney / 2} in your Account"),
                    actions: [
                      ElevatedButton(
                          onPressed: () async {
                            await FireDb.UpdateMoney(
                                widget.questionmoney == 5000
                                    ? 0
                                    : widget.questionmoney ~/ 2);
                            timer?.cancel();
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: Text('Quit')),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('cancle'))
                    ],
                  ));
            },
            child: Text(
              'Quit the game',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ),
          backgroundColor: Colors.transparent,
          drawer: LifeLine(),
          appBar: AppBar(
            title: Text("${widget.questionmoney} Rs"),
            centerTitle: true,
            actions: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  'Score:',
                  style: TextStyle(fontSize: 18),
                ),
              )
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.15,
                width: size.width * 0.25,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CircularProgressIndicator(
                      strokeWidth: 12,
                      backgroundColor: Colors.green,
                      value: Second / maximumSecond,
                    ),
                    Center(
                        child: Text(
                          '${Second.toString()} sec',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Container(
                padding: EdgeInsets.all(14),
                margin: EdgeInsets.all(17),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  questionModel.question,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22),
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              InkWell(
                onTap: () {
                  print('duble press to lock');
                },
                onLongPress: () {
                  setState(() {
                    optionAlocked = true;
                  });
                  Future.delayed(Duration(seconds: 2), () async {
                    if (questionModel.opt1 == questionModel.correctAnswer) {
                      setState(() {
                        correctscore++;
                      });
                      await FireDb.UpdateMoney(widget.questionmoney);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => WinScreen(
                                winmoney: widget.questionmoney,
                                QuizId: widget.QuizId,
                              )));
                    } else {
                      setState(() {
                        wrongscore++;
                      });
                      await FireDb.UpdateMoney(widget.questionmoney ~/ 2);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => Loser(
                                winmoney: 0,
                                correctAnswer: questionModel.correctAnswer,
                              )));
                    }
                  });
                },
                child: Container(
                  width: size.width,
                  padding: EdgeInsets.all(14),
                  margin: EdgeInsets.symmetric(horizontal: 17, vertical: 5),
                  decoration: BoxDecoration(
                      color: optionAlocked
                          ? Colors.yellow.withOpacity(0.4)
                          : Colors.white.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    'B.   ${questionModel.opt1} ',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              InkWell(
                onTap: () {
                  print('duble press to lock');
                },
                onLongPress: () {
                  setState(() {
                    optionBlocked = true;
                  });
                  Future.delayed(Duration(seconds: 2), () async {
                    if (questionModel.opt2 == questionModel.correctAnswer) {
                      await FireDb.UpdateMoney(widget.questionmoney);
                      setState(() {
                        correctscore++;
                      });
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => WinScreen(
                                winmoney: widget.questionmoney,
                                QuizId: widget.QuizId,
                              )));
                    } else {
                      setState(() {
                        wrongscore--;
                      });
                      await FireDb.UpdateMoney(widget.questionmoney ~/ 2);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => Loser(
                                    winmoney: 0,
                                    correctAnswer: questionModel.correctAnswer,
                                  )));
                    }
                  });
                },
                child: Container(
                  width: size.width,
                  padding: EdgeInsets.all(14),
                  margin: EdgeInsets.symmetric(horizontal: 17, vertical: 5),
                  decoration: BoxDecoration(
                      color: optionBlocked
                          ? Colors.yellow.withOpacity(0.4)
                          : Colors.white.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    'B.   ${questionModel.opt2} ',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              InkWell(
                onTap: () {
                  print('duble press to lock');
                },
                onLongPress: () {
                  setState(() {
                    optionClocked = true;
                  });
                  Future.delayed(Duration(seconds: 2), () async {
                    if (questionModel.opt3 == questionModel.correctAnswer) {
                      await FireDb.UpdateMoney(widget.questionmoney);
                      setState(() {
                        correctscore++;
                      });
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => WinScreen(
                                    winmoney: widget.questionmoney,
                                    QuizId: widget.QuizId,
                                  )));
                    } else {
                      await FireDb.UpdateMoney(widget.questionmoney ~/ 2);
                      setState(() {
                        wrongscore--;
                      });
                      Navigator.pushReplacement(
                           context,
                          MaterialPageRoute(
                      builder: (_) => Loser(
                                    winmoney: 0,
                                     correctAnswer: questionModel.correctAnswer,


                      )));
                    }
                  });
                },
                child: Container(
                  width: size.width,
                  padding: EdgeInsets.all(14),
                  margin: EdgeInsets.symmetric(horizontal: 17, vertical: 5),
                  decoration: BoxDecoration(
                      color: optionClocked
                          ? Colors.yellow.withOpacity(0.4)
                          : Colors.white.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    'B.   ${questionModel.opt3} ',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              InkWell(
                onTap: () {
                  print('duble press to lock');
                },
                onLongPress: () {
                  setState(() {
                    optionDlocked = true;
                  });
                  Future.delayed(Duration(seconds: 2), () async {
                    if (questionModel.opt4 == questionModel.correctAnswer) {
                      setState(() {
                        correctscore++;
                      });
                      await FireDb.UpdateMoney(widget.questionmoney);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => WinScreen(
                                winmoney: widget.questionmoney,
                                QuizId: widget.QuizId,
                              )));
                    } else {
                      setState(() {
                        wrongscore--;
                      });
                      await FireDb.UpdateMoney(widget.questionmoney ~/ 2);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => Loser(
                                winmoney: 0,
                                correctAnswer: questionModel.correctAnswer,
                              )));
                    }
                  });
                },
                child: Container(
                  width: size.width,
                  padding: EdgeInsets.all(14),
                  margin: EdgeInsets.symmetric(horizontal: 17, vertical: 5),
                  decoration: BoxDecoration(
                      color: optionDlocked
                          ? Colors.yellow.withOpacity(0.4)
                          : Colors.white.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    'B.   ${questionModel.opt4} ',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
