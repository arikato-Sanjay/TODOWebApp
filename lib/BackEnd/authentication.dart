import 'package:TODO/BackEnd/HelperFunctions.dart';
import 'package:TODO/BackEnd/database.dart';
import 'package:TODO/workplace.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication{

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<FirebaseUser> signInUsingGoogle(BuildContext context) async{
    final GoogleSignIn signIn = new GoogleSignIn();
    final GoogleSignInAccount signInAccount = await signIn.signIn();
    final GoogleSignInAuthentication signInAuthentication = await
        signInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: signInAuthentication.idToken,
        accessToken: signInAuthentication.accessToken);

    AuthResult authResult = await firebaseAuth.signInWithCredential(credential);

    FirebaseUser userData = authResult.user;

    if(authResult != null){
      Map<String, String> userDataMap = {
        "username" : userData.displayName,
        "email" : userData.email
      };
      BackendServices().uploadUserData(userData.uid, userDataMap);
      SharedPreferenceFunction.saveUserId(userData.uid);
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => WorkPlace(
            userEmail: userData.email,
            userName: userData.displayName,
          )
      ));
    }

    return userData;
  }

  Future signOut() async{
    try{
      return firebaseAuth.signOut();
    } catch(e){
      print(e.toString());
    }
  }
}