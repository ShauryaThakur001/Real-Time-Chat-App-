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

  // ✅ Current User ID (SAFE)
  String? get currentUserId => FirebaseAuth.instance.currentUser?.uid;

  // ✅ Chat ID (SAFE)
  String get chatId {
    if (currentUserId == null || widget.receiverId.isEmpty) return "";
    return ChatService.getChatId(currentUserId!, widget.receiverId);
  }

  // ✅ Send Message
  Future<void> sendMessage() async {
    final text = messageController.text.trim();

    if (text.isEmpty || currentUserId == null || chatId.isEmpty) return;

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
    // 🔒 If auth not ready yet
    if (currentUserId == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

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
                      color: Colors.black),
                ),
                const Text(
                  "online",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.video_call, color: Colors.grey.shade800),
              onPressed: () {}),
          IconButton(
              icon: Icon(Icons.call, color: Colors.grey.shade800),
              onPressed: () {}),
          IconButton(
              icon: Icon(Icons.more_vert, color: Colors.grey.shade800),
              onPressed: () {}),
        ],
      ),

      // 🔹 Body
      body: Column(
        children: [

          /// 🔥 IMPORTANT FIX HERE
          Expanded(
            child: chatId.isEmpty
                ? const Center(child: Text("Loading..."))
                : StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("chats")
                        .doc(chatId)
                        .collection("messages")
                        .orderBy("timestamp", descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {

                      // 🔄 Loading
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                            child: CircularProgressIndicator());
                      }

                      // 🟡 No messages yet
                      if (!snapshot.hasData ||
                          snapshot.data!.docs.isEmpty) {
                        return const Center(
                          child: Text(
                            "Start chatting 👋",
                            style: TextStyle(color: Colors.grey),
                          ),
                        );
                      }

                      final messages = snapshot.data!.docs;

                      return ListView.builder(
                        reverse: true,
                        padding: const EdgeInsets.all(10),
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final data = messages[index].data()
                              as Map<String, dynamic>;

                          return MessageBubble(
                            message: data["text"] ?? "",
                            isMe: data["senderId"] == currentUserId,
                          );
                        },
                      );
                    },
                  ),
          ),

          // 🔹 Input Bar
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              border:
                  Border(top: BorderSide(color: Colors.grey.shade300)),
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12),
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
                    onPressed: sendMessage,
                    icon:
                        const Icon(Icons.send, color: Colors.white),
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