import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/views/quizscreens/questionui.dart';

import '../../services/firedb.dart';
import 'LOSER.dart';

class WinScreen extends StatefulWidget {
WinScreen({Key? key,required this.winmoney,required this.QuizId}) : super(key: key);
int winmoney;
String QuizId;

  @override
  State<WinScreen> createState() => _WinScreenState();
}

class _WinScreenState extends State<WinScreen> {
  late ConfettiController confettiController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      initController();
    });
    confettiController.play();
  }

  void initController() {
    confettiController = ConfettiController(duration: Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {

    Future<bool?> showWarning({ required  BuildContext context , required String title , required String content}) async => showDialog(
        context: context,
        builder: (context)=>AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            ElevatedButton(
                onPressed: () => Navigator.pop(context , false),
                child: Text("No!")
            ),
            ElevatedButton(
                onPressed: () async{
                  await FireDb.UpdateMoney( widget.winmoney == 5000 ? 0 : widget.winmoney~/2);

                  Navigator.pop(context , true);
                },
                child: Text("Okay!")
            ),
          ],
        )
    );
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
        child: WillPopScope(
          onWillPop: () async {
            final exitQuiz = await showWarning(
                context: context,
                title: "DO YOU WANT TO EXIT QUIZ ?",
                content:
                "You Will Get Rs.${widget.winmoney == 5000 ? 0 : widget.winmoney/ 2} In Your Account.");
            return exitQuiz ?? false;
          },
          child: Scaffold(
            floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: ElevatedButton(
                onPressed: () {}, child: Text('Shares with frends')),
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Congratulations !',
                        style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text(
                        'Your Answer is Correct ',
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
                        'Rs ${widget.winmoney}',
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Image.network(
                            "https://tse2.mm.bing.net/th?id=OIP.2Wj4ZHFLwAsxy_RCcFHe5AHaDO&pid=Api&P=0"),
                      ),
                      ElevatedButton(
                          onPressed: () {
                           Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>QuestionScreen(
                             QuizId: widget.QuizId,
                             questionmoney: (widget.winmoney)*2,)
                           )
                           );
                          },
                          child: Text('Next Question'))
                    ],
                  ),
                ),
                buildCofittiwidget(confettiController, 90)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Align buildCofittiwidget(controller, double blastdirection) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConfettiWidget(
        maximumSize: Size(30, 30),
        shouldLoop: false,
        confettiController: controller,
        blastDirection: blastdirection,
        blastDirectionality: BlastDirectionality.explosive,
        maxBlastForce: 20,
        minBlastForce: 8,
        emissionFrequency: 0.02,
        numberOfParticles: 8,
        gravity: 0.6,
      ),
    );
  }
}
