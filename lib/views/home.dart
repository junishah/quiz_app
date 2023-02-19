import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/data/constants.dart';
import 'package:quiz_app/views/quizscreens/quiz_intro.dart';
import 'package:quiz_app/widgets/drawer.dart';
import 'package:quiz_app/services/localdb.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../services/home_firedb.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLogin = false;
  String name = "username";
  String money = "-- ";
  String rank = " --";
  String level = " --";
  String profileUrl = " ";
  late List quizez = [];
  bool isLoading = true;

  void getUserDetails() async {
    await localDb.getUserName().then((value) {
      setState(() {
        name = value.toString();
      });
    });

    await localDb.getUserMoney().then((value) {
      setState(() {
        money = value.toString();
      });
    });

    await localDb.getUserRank().then((value) {
      setState(() {
        rank = value.toString();
      });
    });
    await localDb.getUserLevel().then((value) {
      setState(() {
        level = value.toString();
      });
    });
    await localDb.getUserImageUrl().then((value) {
      setState(() {
        profileUrl = value.toString();
      });
    });
  }

  getQuizez() async {
    await HomeFiredb.getQuizez().then((returned_quizez) {
      setState(() {
        quizez = returned_quizez;
        isLoading = false;
      });
    });
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  late Map<String, dynamic> TopPlayer;
  getTopPlayer() async {
    await firestore.collection('user').orderBy("money",descending: false).get().then((value) {
      setState(() {
        TopPlayer = value.docs.elementAt(0).data();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getUserDetails();
    getQuizez();
    getTopPlayer();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return isLoading
        ? Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Quiz App',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 40, horizontal: 40),
              child: LinearProgressIndicator(),
            )
          ],
        ),
      ),
    )
        : RefreshIndicator(
      onRefresh: () async {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => Home()));
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          title: Text('our quiz app'),
          backgroundColor: backgroundColor,
          centerTitle: true,
          shadowColor: Colors.transparent,
        ),
        drawer: SideNav(
          name: name,
          money: money,
          rank: rank,
          profileUrl: profileUrl,
          level: level,
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    height: size.height * 0.2,
                    width: size.width,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://tse2.mm.bing.net/th?id=OIP.D843t6qzqwp2XoX4ZgM5GQHaEK&pid=Api&P=0'),
                            fit: BoxFit.cover)),
                    child: Center(
                        child: Text(
                          '',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        )),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                Padding(
                  padding:
                  EdgeInsets.symmetric(vertical: size.height * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 35,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 35,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 35,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 35,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: size.width * 0.04),
                  child: Container(
                    child: Row(
                      children: [
                        Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Stack(
                              children: [
                                Card(
                                  elevation: 8,
                                  child: Container(
                                      height: size.height * 0.25,
                                      child: Image.network(
                                          'https://tse1.mm.bing.net/th?id=OIP.YMdbjLrzripYY3TXjZpquwHaEK&pid=Api&P=0')),
                                ),
                              ],
                            )),
                        SizedBox(
                          width: size.width * 0.02,
                        ),
                        Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Stack(
                              children: [
                                Card(
                                  elevation: 8,
                                  child: Container(
                                      height: size.height * 0.25,
                                      child: Image.network(
                                          'https://tse1.mm.bing.net/th?id=OIP.YMdbjLrzripYY3TXjZpquwHaEK&pid=Api&P=0')),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: size.width * 0.04),
                  child: Container(
                    child: Row(
                      children: [
                        Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Stack(
                              children: [
                                Card(
                                  elevation: 8,
                                  child: Container(
                                      height: size.height * 0.25,
                                      child: Image.network(
                                          'https://talib.pk/test-preparation/wp-content/uploads/2020/09/MDCAT-Entry-Test-Preparation-2020-Online-MCQs.jpg')),
                                ),
                              ],
                            )),
                        SizedBox(
                          width: size.width * 0.02,
                        ),
                        Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Stack(
                              children: [
                                Card(
                                  elevation: 8,
                                  child: Container(
                                      height: size.height * 0.25,
                                      child: Image.network(
                                          'https://talib.pk/test-preparation/wp-content/uploads/2020/09/MDCAT-Entry-Test-Preparation-2020-Online-MCQs.jpg')),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      height: size.height * 0.15,
                      child: Stack(
                        children: [
                          Card(
                            elevation: 8,
                            child: Container(
                                height: size.height * 0.25,
                                width: size.width,
                                child: Image.network(
                                    'https://talib.pk/test-preparation/wp-content/uploads/2020/09/MDCAT-Entry-Test-Preparation-2020-Online-MCQs.jpg')),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.06,
                      vertical: size.width * 0.03),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Top player in this week",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundImage:
                            NetworkImage(TopPlayer["photourl"]),
                            radius: 50,
                          ),
                          SizedBox(
                            width: size.width * 0.10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(TopPlayer["name"]
                                  .toString()
                                  .length >=
                                  12
                                  ? " ${TopPlayer["name"].toString().substring(0, 17)}.."
                                  : "${TopPlayer["name"].toString()}",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),),


                              Text(
                                "Rs ${TopPlayer["money"]}",
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "Unlock New Quizez",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.04),
                        child: Container(
                          height: size.height * 0.25,
                          //color: Colors.white30,
                          child: Row(
                            children: [
                              Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  QuizIntro(
                                                    QuizAbout: (quizez[
                                                    0])["aboutquiz"],
                                                    QuizDuration: (quizez[
                                                    0])["duration"],
                                                    Quizname: (quizez[0])[
                                                    "quizname"],
                                                    QuizTopic: (quizez[
                                                    0])["topics"],
                                                    QuizUrl: (quizez[0])[
                                                    "quizthumbnail"],
                                                    QuizId: (quizez[0])[
                                                    "myquizid"],
                                                    QuizPrice: (quizez[
                                                    0])[
                                                    "unlockmoney"],
                                                  )));
                                    },
                                    child: Stack(
                                      children: [
                                        Card(
                                          elevation: 8,
                                          child: Container(
                                              height: size.height * 0.25,
                                              child: Image.network(
                                                  (quizez[0])[
                                                  "quizthumbnail"],
                                                  fit: BoxFit.fill)),
                                        ),
                                      ],
                                    ),
                                  )),
                              SizedBox(
                                width: size.width * 0.01,
                              ),
                              Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  QuizIntro(
                                                    QuizAbout: (quizez[
                                                    1])["aboutquiz"],
                                                    QuizDuration: (quizez[
                                                    1])["duration"],
                                                    Quizname: (quizez[1])[
                                                    "quizname"],
                                                    QuizTopic: (quizez[
                                                    1])["topics"],
                                                    QuizUrl: (quizez[1])[
                                                    "quizthumbnail"],
                                                    QuizId: (quizez[1])[
                                                    "myquizid"],
                                                    QuizPrice: (quizez[
                                                    1])[
                                                    "unlockmoney"],
                                                  )));
                                    },
                                    child: Stack(
                                      children: [
                                        Card(
                                          elevation: 8,
                                          child: Container(
                                              height: size.height * 0.25,
                                              child: Image.network(
                                                  (quizez[1])[
                                                  "quizthumbnail"],
                                                  fit: BoxFit.fill)),
                                        ),
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.04),
                        child: Container(
                          height: size.height * 0.20,
                          child: Row(
                            children: [
                              Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
                                  child: Stack(
                                    children: [
                                      Card(
                                        elevation: 8,
                                        child: Container(
                                            height: size.height * 0.25,
                                            child: Image.network(
                                                'https://talib.pk/test-preparation/wp-content/uploads/2020/09/MDCAT-Entry-Test-Preparation-2020-Online-MCQs.jpg')),
                                      ),
                                    ],
                                  )),
                              SizedBox(
                                width: size.width * 0.01,
                              ),
                              Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
                                  child: Stack(
                                    children: [
                                      Card(
                                        elevation: 8,
                                        child: Container(
                                            height: size.height * 0.25,
                                            child: Image.network(
                                                'https://talib.pk/test-preparation/wp-content/uploads/2020/09/MDCAT-Entry-Test-Preparation-2020-Online-MCQs.jpg')),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.04),
                        child: Container(
                          height: size.height * 0.20,
                          child: Row(
                            children: [
                              Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
                                  child: Stack(
                                    children: [
                                      Card(
                                        elevation: 8,
                                        child: Container(
                                            height: size.height * 0.25,
                                            child: Image.network(
                                                'https://talib.pk/test-preparation/wp-content/uploads/2020/09/MDCAT-Entry-Test-Preparation-2020-Online-MCQs.jpg')),
                                      ),
                                    ],
                                  )),
                              SizedBox(
                                width: size.width * 0.01,
                              ),
                              Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
                                  child: Stack(
                                    children: [
                                      Card(
                                        elevation: 8,
                                        child: Container(
                                            height: size.height * 0.25,
                                            child: Image.network(
                                                'https://talib.pk/test-preparation/wp-content/uploads/2020/09/MDCAT-Entry-Test-Preparation-2020-Online-MCQs.jpg')),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      height: size.height * 0.15,
                      child: Stack(
                        children: [
                          Card(
                            elevation: 8,
                            child: Container(
                                height: size.height * 0.25,
                                width: size.width,
                                child: Image.network(
                                    'https://talib.pk/test-preparation/wp-content/uploads/2020/09/MDCAT-Entry-Test-Preparation-2020-Online-MCQs.jpg')),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: CarouselSlider(
                      items: [
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    "https://talib.pk/test-preparation/wp-content/uploads/2020/09/MDCAT-Entry-Test-Preparation-2020-Online-MCQs.jpg"),
                                fit: BoxFit.cover),
                          ),
                          //height: size.height * 0.25,
                        ),
                      ],
                      options: CarouselOptions(
                        height: size.height * 0.2,
                        enableInfiniteScroll: true,
                        autoPlay: true,
                        aspectRatio: 16 / 9,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        autoPlayAnimationDuration: Duration(seconds: 3),
                        viewportFraction: 0.8,
                      )),
                ),
                Padding(
                  padding:
                  EdgeInsets.symmetric(vertical: size.height * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 35,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 35,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 35,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                  EdgeInsets.symmetric(vertical: size.height * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 35,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 35,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 35,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                  EdgeInsets.symmetric(vertical: size.height * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 35,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 35,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 35,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Text(
                  "v1.0 made by junishah",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
