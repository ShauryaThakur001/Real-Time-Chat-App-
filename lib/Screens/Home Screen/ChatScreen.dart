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
        backgroundColor: Colors.blueGrey.shade50,
        body: Column(
          children: [
            Expanded(child: ListView(
              padding: EdgeInsets.all(10),
              children: [
                Text("Hello Shaurya"),
                Text("How are you??"),
              ],
            )),
            Container(
              child: Row(
                children: [
                  
                ],
              ),
            )
          ],
        ),
        ),
    );
  }
}
