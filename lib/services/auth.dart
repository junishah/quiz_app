



import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quiz_app/views/home.dart';
import 'firedb.dart';
import 'localdb.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn= GoogleSignIn();

Future<User?> signInWithGoogle()async{
  try{


  final GoogleSignInAccount?  googlesignIAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication? googleSignInAuthentication= await googlesignIAccount?.authentication;
  final AuthCredential credential = GoogleAuthProvider.credential(idToken: googleSignInAuthentication?.idToken,accessToken: googleSignInAuthentication?.accessToken);
  final usercredential = await auth.signInWithCredential(credential);
  final User? user= usercredential.user;
  assert(!user!.isAnonymous);
  assert(await user!.getIdToken()!=null);
  final User? currentuser= await auth.currentUser;
assert(currentuser!.uid==user!.uid);

  await FireDb().createNewUser(user!.displayName.toString(),
    user!.email.toString(),
    user!.photoURL.toString(),
    user!.uid.toString(),);
  await localDb.saveUserId(user.uid);
  await localDb.saveUserName(user.displayName.toString());
  await localDb.saveUserImageUrl(user.photoURL.toString());


  print(user);

  }
  catch(e){
    print('error in sign in');
    print(e);
  };


}

Future<String> signOut()async{
  await googleSignIn.signOut();
  await auth.signOut();
  await localDb.saveUserId('null');
  return " SUCCESS";

}