import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/Home%20Screen/MessageBubble.dart';

class ChatScreen extends StatelessWidget {
  final String userId;
  final String name;
  final String photoUrl;

  const ChatScreen({
    super.key,
    required this.userId,
    required this.name,
    required this.photoUrl,
  });

  @override
  Widget build(BuildContext context) {

    List messages = [
  {"text": "Hello", "senderId": "user1"},
  {"text": "Hi", "senderId": "user2"},
  {"text": "How are you?", "senderId": "user1"},
];
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.black),
        ),

        titleSpacing: 0,

        title: Row(
          children: [
            CircleAvatar(radius: 18, backgroundImage: NetworkImage(photoUrl)),
            SizedBox(width: 10),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "online",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),

        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.video_call, color: Colors.grey.shade800),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.call, color: Colors.grey.shade800),
          ),
          PopupMenuButton(
            icon: Icon(Icons.more_vert, color: Colors.grey.shade800),
            itemBuilder: (context) => [
              PopupMenuItem(child: Text("View Contact")),
              PopupMenuItem(child: Text("Media")),
              PopupMenuItem(child: Text("Mute")),
              PopupMenuItem(child: Text("Block")),
            ],
          ),
        ],
      ),
      body: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.blueGrey.shade50,
        body: Column(
          children: [
            SizedBox(height: 10,),
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {

                  var msg=messages[index];
                  
                  return MessageBubble(
                    message: msg["text"], 
                    isMe: msg["senderId"]=='user2'
                    );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Colors.grey.shade300)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey.shade200,
                    child: Icon(Icons.add, color: Colors.black,size: 30,),
                  ),
                  SizedBox(width: 8,),
                  Expanded(child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 13),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(25)
                    ),
                    child: Row(
                      children: [
                        Expanded(child: TextField(
                          decoration: InputDecoration(hintText: "Type a message...",border: InputBorder.none),
                        ))
                      ],
                    ),
                  )),
                  SizedBox(width: 8,),
                  CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.send,color: Colors.white,),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
