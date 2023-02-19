import 'package:flutter/material.dart';
import 'package:quiz_app/views/quizscreens/questionui.dart';

import '../../services/QuizQuestioncreator.dart';
import '../../services/checkquizunlock.dart';
import '../../services/home_firedb.dart';
import '../../services/quizpurchase.dart';

class QuizIntro extends StatefulWidget {
  QuizIntro(
      {Key? key,
      required this.QuizAbout,
      required this.QuizDuration,
      required this.Quizname,
      required this.QuizTopic,
      required this.QuizUrl,
      required this.QuizId,
      required this.QuizPrice})
      : super(key: key);
  String Quizname;
  String QuizUrl;
  String QuizTopic;
  String QuizDuration;
  String QuizAbout;
  String QuizId;
  String QuizPrice;

  @override
  State<QuizIntro> createState() => _QuizIntroState();
}

class _QuizIntroState extends State<QuizIntro> {

  bool quizisunlocked = false;
  getQuizUnLockStatus() async {
    await CheckQuizUnlock.checkquizUnlock(widget.QuizId).then((unlockstatus) {
      setState(() {
        quizisunlocked = unlockstatus;
      });
    });
  }


  @override
  void initState() {
    getQuizUnLockStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
          onPressed: () {
            quizisunlocked
                ? Navigator.push(context, MaterialPageRoute(builder: (context)=>QuestionScreen(
                QuizId:widget.QuizId, questionmoney:5000 )))
                : QuizPerchase.buyQuiz(
                        quizprice: int.parse(widget.QuizPrice),
                        QuizId: widget.QuizId)
                    .then((value) {
                    if (value) {
                      setState(() {
                        quizisunlocked = true;
                      });
                    } else {
                      return showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text("You dont have enough money"),
                                actions: [
                                  TextButton(
                                      onPressed: () {}, child: Text('gggg'))
                                ],
                              ));
                    }
                  });
          },
          child: Text(quizisunlocked ? 'Start Quiz' : " unlock quiz")),
      appBar: AppBar(
        title: Text("Quiz Intro"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(bottom: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: size.width,
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.Quizname,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                height: size.height * 0.2,
                width: size.width,
                child: Image.network(
                  widget.QuizUrl,
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                padding: EdgeInsets.all(18),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.topic_outlined),
                        SizedBox(
                          width: size.width * 0.02,
                        ),
                        Text(
                          "Rlated to",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        )
                      ],
                    ),
                    Text(
                      widget.QuizTopic,
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(18),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.timer),
                        SizedBox(
                          width: size.width * 0.02,
                        ),
                        Text(
                          "Duration",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        )
                      ],
                    ),
                    Text(
                      "${widget.QuizDuration} Minutes",
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(18),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.topic_outlined),
                        SizedBox(
                          width: size.width * 0.02,
                        ),
                        Text(
                          "About Quiz",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        )
                      ],
                    ),
                    Text(
                      widget.QuizAbout,
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
