

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiz_app/services/localdb.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final FirebaseFirestore firestore= FirebaseFirestore.instance;

class QuizQuestionCreator{
  static  Future<Map> generateQuestion(String quizId, int questionMoney) async {
final Map questionData;
    final snapshot= await firestore
        .collection('quizez')
        .doc(quizId)
        .collection('Questions')

        .get();
    final docsList = snapshot.docs;

      final randomIndex = Random().nextInt(docsList.length);
     questionData = docsList[randomIndex].data();
      print(questionData);
      return questionData;


  }
}