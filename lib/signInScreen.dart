import 'package:TODO/BackEnd/authentication.dart';
import 'package:flutter/material.dart';
import 'BackEnd/HelperFunctions.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  Authentication authentication = new Authentication();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Make this Happen",
      style: TextStyle(
        color: Colors.white,
        fontSize: 20
      ),),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("assets/images/logo.jpg", height: 200, width: 280,),
            SizedBox(height: 16,),
            Text("TODO WebApp for Procrastinators", style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic
            ),),
            SizedBox(height: 16,),
            GestureDetector(
              onTap: (){
                authentication.signInUsingGoogle(context);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(30)
                ),
                child: Text("SignIn With Google", style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
