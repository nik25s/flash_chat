import 'package:flash_chat/free.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/chat_screen.dart';

void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: WelcomeScreen(),
      initialRoute: 'welcome',
      routes: {  
        'welcome': (context) => WelcomeScreen(),
        'chat': (context) => ChatScreen(),
        'login': (context) => LoginScreen(),
        'register': (context) => RegistrationScreen(),
      },
    );
  }
}
