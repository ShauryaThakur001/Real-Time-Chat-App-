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
    required this.photoUrl,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    // ✅ ALWAYS get user here (not in initState / getter)
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Scaffold(
        body: Center(child: Text("Please login again")),
      );
    }

    final currentUserId = user.uid;

    // ✅ SINGLE SOURCE OF chatId (VERY IMPORTANT)
    final chatId = ChatService.getChatId(
      currentUserId,
      widget.receiverId,
    );

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,

      // 🔹 AppBar
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        titleSpacing: 0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage(widget.photoUrl),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const Text(
                  "online",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),

      // 🔹 Body
      body: Column(
        children: [

          /// 🔥 Messages
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("chats")
                  .doc(chatId)
                  .collection("messages")
                  .orderBy("timestamp", descending: true)
                  .snapshots(),
              builder: (context, snapshot) {

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text("Start chatting 👋"),
                  );
                }

                final messages = snapshot.data!.docs;

                return ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.all(10),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {

                    final data =
                        messages[index].data() as Map<String, dynamic>;

                    return MessageBubble(
                      message: data["text"] ?? "",
                      isMe: data["senderId"] == currentUserId,
                    );
                  },
                );
              },
            ),
          ),

          /// 🔹 Input Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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
                  child: const Icon(Icons.add, color: Colors.black),
                ),

                const SizedBox(width: 8),

                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextField(
                      controller: messageController,
                      decoration: const InputDecoration(
                        hintText: "Type a message...",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: IconButton(
                    onPressed: () async {

                      final text = messageController.text.trim();
                      if (text.isEmpty) return;

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
                    },
                    icon: const Icon(Icons.send, color: Colors.white),
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