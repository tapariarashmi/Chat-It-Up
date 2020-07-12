import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'buttons.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>{

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(padding: EdgeInsets.symmetric(horizontal:15.0),
      child :Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
         
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Hero(tag: 'logo',
                 child: Container(
           // padding: EdgeInsets.all(5.0),
            height: 60.0,
              child: Image.asset('images/chatapp.png'),
          ),
                ),
                SizedBox(
                  width :5.0,
                  ),
          TypewriterAnimatedTextKit(
            text: ['Flash Chat'],
            textStyle: TextStyle(
            fontSize : 50.0,
            fontWeight : FontWeight.bold,
            color: Colors.blue,
          ),
          speed: Duration(seconds: 1),
          isRepeatingAnimation: false,
          
                ),
              ],
          ),
          SizedBox(
            height: 40.0,
          ),
          RoundedButton(
            color: Colors.lightBlueAccent,
            text: 'LOG IN',
            onPressed:(){
                Navigator.pushNamed(context, 'login_screen');
              },
               ),
               RoundedButton(
            color: Colors.blue,
            text: 'REGISTER',
            onPressed:(){
                Navigator.pushNamed(context, 'registeration_screen');
              },
               ),
           
        ],
      ),
    ),
    );
  }
}


