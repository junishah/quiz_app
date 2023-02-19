

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final FirebaseFirestore firestore= FirebaseFirestore.instance;

class HomeFiredb{

   static Future<List<Map<String,dynamic>>> getQuizez()async{
     List<Map<String,dynamic>> allquiz=[];
   await firestore.collection("quizez").get().then((querySnapshot) {
     querySnapshot.docs.forEach((quiz) {
       Map<String, dynamic>myQuiz= quiz.data();
       myQuiz["myquizid"]=quiz.reference.id;
       print(quiz.data());
       allquiz.add(myQuiz);

     });

   });
   return allquiz;
    

  }
}