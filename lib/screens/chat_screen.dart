import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
   User? loggedinuser;
class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _firestore=FirebaseFirestore.instance;
  final _auth=FirebaseAuth.instance;
  late String messagetext;
   void initState(){
    super.initState();
    getcurrentuser();
   }
  void getcurrentuser() async{
    try {
      
    final user=await _auth.currentUser;
    if (user!=null) {
      loggedinuser=user;
      print(loggedinuser!.email);
    }
    } 
    catch(e){
      print(e);
    }
  }
  void messagestream() async{
    await for(var snapshot in _firestore.collection('messages').snapshots()){
      for (var message in snapshot.docs) {
        print(message.data());
        
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                messagestream();
              //   _auth.signOut();
              //   Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                      messagetext=value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      _firestore.collection('messages').add({
                        'text':messagetext,
                        'sender':loggedinuser!.email,
                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// Documentation id of firestore database : ZoD5b8OAJMvLGVwpNRLT