import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
FirebaseUser loggedInUser;
final _firestore = Firestore.instance;
class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String messageText;
  final messageTextController = TextEditingController();
  
  final _auth = FirebaseAuth.instance;
  

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  void getCurrentUser() async{
    try{
    final user = await _auth.currentUser();
    if(user!= null){
          loggedInUser = user;
          print(loggedInUser.email);
    }
    }
    catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: (){
              _auth.signOut();
              Navigator.pop(context);
            },
          ),
        ],
        title: Text('Chat'),
      ),


      body: SafeArea(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(),
              Container(
                child:Row(
                  children: <Widget>[
                    Expanded(
                    child: TextField(
                      
                      controller: messageTextController,
                      onChanged: (value){
                        messageText = value;

                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10.0),
                        hintText: 'Write a message...',
                      ),

                    ),
                    ),
                    FlatButton(

                      child: Text(
                        'SEND',
                        style: TextStyle(
                        color: Colors.lightBlueAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        ),
                        ),
                      onPressed: (){
                        messageTextController.clear();
                        _firestore.collection('messages').add({
                          'text': messageText,
                          'sender': loggedInUser.email,
                          'time': FieldValue.serverTimestamp()
                        });
                    },
      
                    ),
                  ],
                ),
              ),
        ],),
        ),

    );
  }
}

class MessagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('messages').orderBy('time', descending: false).snapshots(),
              builder: (context,snapshot){
                if(!snapshot.hasData){
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor : Colors.lightBlueAccent,
                    ),
                  );
                }
                  final messages = snapshot.data.documents.reversed;
                  List<MessageBubble> messageBubbles = [];
                  for(var message in messages){
                    final messageText = message.data['text'];
                    final messageSender = message.data['sender'];
                    
                    final currentUser = loggedInUser.email;
                    
                    final messageBubble = MessageBubble(text: messageText,sender: messageSender,
                    isMe: currentUser==messageSender);
                    messageBubbles.add(messageBubble);                  
                    }
                  
                return Expanded(
                  
                  child: ListView(
                    reverse: true,
                    padding: EdgeInsets.all(10.0),
                    children : messageBubbles,
                  )
                  );
                }
              
              );
  }
}

class MessageBubble extends StatelessWidget {
  final String text;
  final String sender;
  final bool isMe;
  
  MessageBubble({this.text,this.sender,this.isMe});
  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: EdgeInsets.all(5.0), 
    child:Column(
      crossAxisAlignment: isMe? CrossAxisAlignment.end:CrossAxisAlignment.start,
      children:<Widget>[
        Text(
         sender,
          style: TextStyle(
            color:Colors.black45,
            fontSize: 10.0,
          ),
          ),
    Material(
      elevation: 5.0,
      borderRadius: BorderRadius.only(topLeft: isMe? Radius.circular(30.0):Radius.circular(0.0),
      bottomLeft: Radius.circular(30.0),bottomRight: Radius.circular(30.0),
      topRight: isMe? Radius.circular(0.0):Radius.circular(30.0)),

      color: isMe? Colors.lightBlueAccent:Colors.white,
      child: Padding( 
        padding: EdgeInsets.symmetric(horizontal:15.0,vertical:10.0),
      child:Text(
        text,
        style: TextStyle(
          color: isMe? Colors.white:Colors.lightBlueAccent,
          fontSize: 15.0,
        ),
        ),
      ),
    ),
      ],
      ),
    );
      
    
  }
}