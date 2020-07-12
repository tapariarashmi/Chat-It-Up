import 'package:flutter/material.dart';
import 'buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegisterationScreen extends StatefulWidget {
  @override
  _RegisterationScreenState createState() => _RegisterationScreenState();
}

class _RegisterationScreenState extends State<RegisterationScreen> {
  bool showSpinner = false;
  String email;
  String password;
  final _auth = FirebaseAuth.instance;
  final messageTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(inAsyncCall: showSpinner, 
    child:Scaffold(
      backgroundColor: Colors.white,
      body: Padding(padding: EdgeInsets.symmetric(horizontal: 15.0),
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
            height: 25.0,
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
           controller: messageTextController,
           obscureText: true,
           textAlign: TextAlign.center,
            onChanged: (value){
              password = value;
            },
            decoration: kTextfieldDecoration.copyWith(hintText: 'Enter Your Password'),
          ),
          SizedBox(
            height: 8.0,
          ),
           RoundedButton(
            color: Colors.blue,
            text: 'REGISTER',
            onPressed:()async{
              messageTextController.clear();
                setState(() {
                  showSpinner = true;
                });
                try{
               final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
               if(newUser!=null){
                 Navigator.pushNamed(context, 'chat_screen');
                 setState(() {
                   showSpinner = false;
                 });
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
    ),
    );
  }
}