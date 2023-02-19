


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiz_app/services/localdb.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final FirebaseFirestore firestore= FirebaseFirestore.instance;
class CheckQuizUnlock{

 static Future<bool> checkquizUnlock(String quiz_doc_id)async{
    String user_id='';
    bool checkUnLocKed=false;
    await localDb.getUserId().then((value) {
      user_id=value!;
    });
    await firestore.collection("user").doc(user_id).collection('unlockquiz').doc(quiz_doc_id).get().then((value){
checkUnLocKed=value.data().toString()!="null";
    });
    return checkUnLocKed;
  }


}