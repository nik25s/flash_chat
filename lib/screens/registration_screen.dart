import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/component/rounded_button.dart';
import 'package:flash_chat/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth=FirebaseAuth.instance;
  bool showspinner=false;


  late String email;
  late String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:ModalProgressHUD(
        inAsyncCall: showspinner,
        child: Padding(
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
                  decoration:ktextfieldDecoration.copyWith(hintText: 'Enter your Email'),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  textAlign: TextAlign.center,
                  obscureText: true, // to hide input
                  onChanged: (value) {
                    password=value;
                  },
                  decoration:ktextfieldDecoration.copyWith(hintText: 'Enter your password'),
                ),
                SizedBox(
                  height: 24.0,
                ),
                buttons(color: Colors.blueAccent, name: 'Register', 
                onPressed:() async{
                  setState(() {
                    showspinner=true;
                  });
                  try{
                final newuser=await _auth.createUserWithEmailAndPassword(email: email, password: password);
                print(newuser);
                if (newuser!=null) {
                  Navigator.pushNamed(context, 'chat');
                }
                setState(() {
                  showspinner=false;
                });
                  }
                  catch(e){
                    print(e);
                  }
              },
              ),
              ],
            ),
          ),
      ),
    );
  }
}
