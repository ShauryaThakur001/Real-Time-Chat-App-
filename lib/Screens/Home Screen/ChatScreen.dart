import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Firebase/FireStore/chat_Service.dart';
import 'package:flutter_application_1/Screens/Home%20Screen/MessageBubble.dart';

class ChatScreen extends StatefulWidget {
  final String receiverId;
  final String name;
  final String photoUrl;

  const ChatScreen({
    super.key,
    required this.receiverId,
    required this.name,
    required this.photoUrl, required String userId,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  TextEditingController messageController = TextEditingController();

  String get chatId {
    return ChatService.getChatId(
      FirebaseAuth.instance.currentUser!.uid,
      widget.receiverId,
    );
  }

  // ✅ Send Message
  Future<void> sendMessage() async {
    String text = messageController.text.trim();

    if (text.isEmpty) return;

    String currentUserId = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance
        .collection("chats")
        .doc(chatId)
        .collection("messages")
        .add({
          "text": text,
          "senderId": currentUserId,
          "timestamp": FieldValue.serverTimestamp(),
        });

    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,

      // 🔹 AppBar
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,

        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: Colors.black),
        ),

        titleSpacing: 0,

        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage(widget.photoUrl),
            ),
            SizedBox(width: 10),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert, color: Colors.grey.shade800),
          ),
        ],
      ),

      // 🔹 Body
      body: Column(
        children: [

          // 🔹 Messages (Realtime)
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("chats")
                  .doc(chatId)
                  .collection("messages")
                  .orderBy("timestamp")
                  .snapshots(),
              builder: (context, snapshot) {

                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                var messages = snapshot.data!.docs;

                return ListView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {

                    var msg = messages[index];

                    return MessageBubble(
                      message: msg["text"],
                      isMe: msg["senderId"] ==
                          FirebaseAuth.instance.currentUser!.uid,
                    );
                  },
                );
              },
            ),
          ),

          // 🔹 Input Bar
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Colors.grey.shade300),
              ),
            ),
            child: Row(
              children: [

                CircleAvatar(
                  backgroundColor: Colors.grey.shade200,
                  child: Icon(Icons.add, color: Colors.black),
                ),

                SizedBox(width: 8),

                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextField(
                      controller: messageController,
                      decoration: InputDecoration(
                        hintText: "Type a message...",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 8),

                // ✅ Send Button
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: IconButton(
                    onPressed: sendMessage,
                    icon: Icon(Icons.send, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}