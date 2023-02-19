




import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiz_app/services/localdb.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final FirebaseFirestore firestore= FirebaseFirestore.instance;
class QuizPerchase{
 static Future<bool> buyQuiz( {required int quizprice ,required String QuizId})async{
    String user_id='';
    bool isEnoughBalance=false;
    await localDb.getUserId().then((value) {
      user_id=value!;
    });
    await firestore.collection('user').doc(user_id).get().then((user) {
  isEnoughBalance=quizprice<= int.parse(user.data()!['money']);
    });

    if(isEnoughBalance){
      await firestore.collection('user').doc(user_id).
      collection('unlockquiz').doc(QuizId).set({
        "unlockedat":DateTime.now()
      });
      print("quiz is unlooked now");
      return true;
    }else{

      print('not enough money');
      return false;
    }
    
  }
  }