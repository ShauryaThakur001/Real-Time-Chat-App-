import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),

        titleSpacing: 0,

        title: Row(
          children: [
            CircleAvatar(radius: 18, backgroundImage: NetworkImage(photoUrl)),
            SizedBox(width: 10),
            Text(name, style: TextStyle(fontSize: 20)),
          ],
        ),
        actions: [
          Icon(Icons.video_chat_rounded,size: 30,color: Colors.grey.shade800,),
          SizedBox(width: 2,),
          Icon(Icons.call,size: 28,color: Colors.grey.shade800,),
          SizedBox(width: 20,),
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Icon(Icons.more_vert,size: 30,color: Colors.grey.shade800,),
          ),
        ],
      ),
      body: Scaffold(
        backgroundColor: Colors.blueGrey.shade50,
      ),
    );
  }
}
