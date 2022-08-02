import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/component/rounded_button.dart';
class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  // for better understanding of Animation watch module no.174(flash_chat)
  late AnimationController controller;
  late Animation animation;
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: Duration(seconds: 1),
        vsync:
            this); //here vsync:this means our _WelcomeScreenState will ticked(changes) in every one second

    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);
    controller.forward();
    // animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    // animation.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     controller.reverse(from: 1.0);// when reverse animation completed its status shows dismissed 
    //   } else if (status == AnimationStatus.dismissed) {
    //     controller.forward(); // when forward animation completed its status showo completed
    //   }
    // });
    controller.addListener(() {
      setState(() {
        print(animation.value); // value of animation changes from 0 to 1 or we can say time of change period
      });
    });
  }

  void dispose() {
    controller.dispose(); // when we left out welcome screen then animation should destroy not running in background
    super.initState;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  //animination for logo image from welcome screen to login & reg screen
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60.0,
                  ),
                ),
                TypewriterAnimatedTextKit(
                  speed:Duration(milliseconds:200),
                  isRepeatingAnimation: false,
                 text: ['Flash Chat'],
                textStyle:TextStyle(color: Colors.black54,
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                    ),
                    ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            buttons(color:Colors.lightBlueAccent,name:'Log In',onPressed:() {
            Navigator.pushNamed(context, 'login');
          },),
            buttons(color:Colors.blueAccent,name:'Register',onPressed:() {
            Navigator.pushNamed(context, 'register');
          },),
          ],
        ),
      ),
    );
  }
}
