import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/component/rounded_button.dart';
import 'package:flash_chat/constant.dart';
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth=FirebaseAuth.instance;
  late String email;
  late String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: 'logo',
              child: Container(
                height: 200.0,
                child: Image.asset('images/logo.png'),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
               textAlign: TextAlign.center,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                email=value;
              },
              decoration: ktextfieldDecoration.copyWith(hintText: 'Enter your Email'),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
               textAlign: TextAlign.center,
              obscureText: true,
              onChanged: (value) {
                password=value;
              },
              decoration: ktextfieldDecoration.copyWith(hintText:'Enter your Password'),
            ),
            SizedBox(
              height: 24.0,
            ),
            buttons(
              color: Colors.lightBlueAccent,
              name: 'Log In',
              onPressed: () async{
                try{
                final user=await _auth.signInWithEmailAndPassword(email: email, password: password);
                if (user!=null) {
                  Navigator.pushNamed(context, 'chat');
                }
                }
                catch(e){
                  print(e);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

 
  
}
