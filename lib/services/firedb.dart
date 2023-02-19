import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiz_app/services/checkquizunlock.dart';
import 'localdb.dart';

class FireDb{
  final FirebaseAuth auth= FirebaseAuth.instance;
  final FirebaseFirestore firestore= FirebaseFirestore.instance;


  createNewUser(String name, String email, String photourl, String uid)async{
    final User? currentuser=auth.currentUser;

    if(await getUser()){
      print("User alredy exist");
    }
    else{
      await firestore.collection('user')
          .doc(currentuser!.uid)
          .set({
        "name":name,
        "email":email,
        "photourl":photourl,
        "money":"O",
        "rank":"NA",
        "level":" 0 ",

      }).then((value) async {
        await localDb.saveUserMoney("0");

        await localDb.saveUserRank("NA");
        await localDb.saveUserLevel("0");

        print("user register successfully");
      });

    }}



  static UpdateMoney(int moneyamount)async{// to store money updated in firestore and in local db

    if(moneyamount!=2500){
      final FirebaseAuth auth= FirebaseAuth.instance;
      final FirebaseFirestore firestore= FirebaseFirestore.instance;
      await firestore.collection('user').doc(auth.currentUser!.uid).get().then((value) async{
        await localDb.saveUserMoney((int.parse(value.data()!["money"])+moneyamount).toString());//to save updated money
        // in loacl db in shared prefrence

        await firestore.collection("user").doc(auth.currentUser!.uid).update({
          "money":(int.parse(value.data()!["money"])+moneyamount).toString(),

        });
      });
    }




  }

  Future<bool> getUser() async{
    final User? currentuser=  auth.currentUser;
    String user="";
    await firestore.collection('user').doc(currentuser?.uid).get().then((value) async {
      user= value.data().toString();
      await localDb.saveUserMoney("5555");
      await localDb.saveUserRank("7777");
      await localDb.saveUserLevel("44");


    });

    if(user.toString()=="null"){
      return false;

    }else{
      await firestore.collection('user').doc(currentuser?.uid).get().then((value) async {
        user= value.data().toString();
        await localDb.saveUserMoney(value["money"]);
        await localDb.saveUserRank(value["rank"]);
        await localDb.saveUserLevel(value["level"]);



      });
      return true;
    }

  }



}