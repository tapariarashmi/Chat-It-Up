import 'package:flutter/material.dart';
import 'buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner=false;
  String email;
  String password;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(inAsyncCall: showSpinner, 
    child:Scaffold(
      backgroundColor: Colors.white,
      body: Padding(padding: EdgeInsets.symmetric(horizontal:15.0),
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Flexible(
            child: Hero(
            tag: 'logo',
            child: Container(
            height: 200.0,
             child: Image.asset('images/chatapp.png'),
          ),
          ),
          ),
          SizedBox(
            height:25.0,
          ),

          TextField(
            keyboardType: TextInputType.emailAddress,
            textAlign: TextAlign.center,
            onChanged: (value){
              email=value;
            },
            decoration: kTextfieldDecoration.copyWith(hintText: 'Enter Your Email'),
          ),
         SizedBox(
           height: 5.0,
         ),
         TextField(
           obscureText: true,
           textAlign: TextAlign.center,
            onChanged: (value){
              password=value;
            },
            decoration: kTextfieldDecoration.copyWith(hintText: 'Enter Your Password'),
          ),
          SizedBox(
            height: 8.0,
          ),
           RoundedButton(
            color: Colors.lightBlueAccent,
            text: 'LOG IN',
            onPressed:()async{
              setState(() {
                showSpinner=true;
              });
              try{
               final user = await _auth.signInWithEmailAndPassword(email: email, password: password);
               if(user!=null){
                 Navigator.pushNamed(context, 'chat_screen');
               }
               setState(() {
                 showSpinner=false;
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



