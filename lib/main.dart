import 'package:flutter/material.dart';
import 'welcome_screen.dart';
import 'login_screen.dart';
import 'registeration_screen.dart';
import 'chat_screen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      //theme: ThemeData.dark(),
      initialRoute: 'welcome_screen',
      routes: {
        'login_screen' : (context) => LoginScreen(),
        'welcome_screen' : (context) => WelcomeScreen(),
        'registeration_screen' : (context) => RegisterationScreen(),
        'chat_screen' : (context) => ChatScreen(),
      },
    );
  }
}

