import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
final _firestore=FirebaseFirestore.instance;
   User? loggedinuser;
class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messagetextcontroller=TextEditingController(); // to controll text like after writing text , text should be clear on textfield
  final _auth=FirebaseAuth.instance;
  late String messagetext;
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
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
          MessaggeStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messagetextcontroller,
                      onChanged: (value) {
                      messagetext=value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      messagetextcontroller.clear(); //after presssing send button previous written text should b wipped
                      _firestore.collection('messages').add({ // this line means it will store all text and user-email-id in firebase collection database 
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
// stream builder widget
class MessaggeStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return     StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('messages').snapshots(),//controll text and useremail store in firebase as a stream 
              builder: (context, snapshot) 
              {
                    if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.lightBlueAccent,
                            ),
                          );
                    }
                      final messages=snapshot.data!.docs.reversed;
                      List<Messagebubble> messageBubbles=[];
                      for (var message in messages) {
                             final messagetext=message['text'];
                             final messagesender=message['sender'];
                              final currentuser=loggedinuser!.email;


                            final messagebubbler=Messagebubble(sender: messagesender, text: messagetext,isme: currentuser!=messagesender,);
                            messageBubbles.add(messagebubbler);
                      }
                         return Expanded(
                           child: ListView(
                            reverse: true,
                            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                              children:messageBubbles,
                           ),
                         );
                    return null!;
              },
              
              );
  }
}



//  message apperance widget
class Messagebubble extends StatelessWidget {
  Messagebubble({required this.sender,required this.text,required this.isme});
  late final String sender;
  late final String text;
  late final bool isme;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isme?CrossAxisAlignment.end:CrossAxisAlignment.start,
        children: [
          Text(sender,style: TextStyle(fontSize: 12,color: Colors.black54),),
          Material(
            borderRadius: isme?BorderRadius.only(topLeft: Radius.circular(30),bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30)):
                              BorderRadius.only(topRight: Radius.circular(30),bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30)),
            elevation: 5.0,
            color: isme ?Colors.lightBlueAccent :Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
              child: Text(text,style:TextStyle(color: isme?Colors.white:Colors.black54),),
            ),
            ),
        ],
      ),
    );
  }
}
// Documentation id of firestore database : ZoD5b8OAJMvLGVwpNRLT