import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Color color;
  final Function onPressed;

RoundedButton({@required this.color,@required this.text,@required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(30.0),
            color: color,
            child: MaterialButton(
              onPressed: onPressed,
              child: Text(text,style: TextStyle(color:Colors.white,fontSize: 20.0,),),
            ),
          ),
          
          );
  }
}

const kTextfieldDecoration = InputDecoration(
              hintText: 'Enter Your Email',
              hintStyle: TextStyle(color: Colors.grey),
              contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical:10.0),
              // border: OutlineInputBorder(
              //   borderRadius: BorderRadius.all(Radius.circular(30.0)),
              // ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                borderSide: BorderSide(color: Colors.lightBlueAccent,width: 1.0),
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                borderSide: BorderSide(color: Colors.lightBlueAccent,width: 2.0),
              ),

            ) ; 