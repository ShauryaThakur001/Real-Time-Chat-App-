import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Firebase/Auth/EmailPasswordLogin.dart';
import 'package:flutter_application_1/Screens/Home%20Screen/ChatScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchCoontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final currentUserId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 7),
          child: CircleAvatar(
            radius: 18,
            backgroundColor: Colors.blue.shade50,
            child: Icon(Icons.person, color: Colors.blue.shade600, size: 30),
          ),
        ),
        title: Text("Messages"),
        actions: [
          CircleAvatar(
            radius: 22,
            backgroundColor: Colors.blue.shade50,
            child: Icon(Icons.camera_alt, color: Colors.blue.shade600),
          ),
          SizedBox(width: 8),
          CircleAvatar(
            radius: 22,
            backgroundColor: Colors.blue.shade50,
            child: Icon(Icons.edit_document, color: Colors.blue.shade600),
          ),
          IconButton(
            onPressed: () {
              Emailpasswordlogin().logOut();
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [

            // 🔍 Search
            TextField(
              controller: searchCoontroller,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.grey.shade600),
                hintText: "Search conversations",
                hintStyle: TextStyle(color: Colors.grey.shade600),
                border: OutlineInputBorder(borderSide: BorderSide.none),
                fillColor: Color(0xFFF0F8FF),
                filled: true,
              ),
            ),

            SizedBox(height: 20),

            // 👥 Users List
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .snapshots(),
                builder: (context, snapshot) {

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text("No users found"));
                  }

                  var users = snapshot.data!.docs;

                  return ListView.separated(
                    itemCount: users.length,
                    itemBuilder: (context, index) {

                      var user = users[index];
                      var data = user.data() as Map<String, dynamic>;

                      // ✅ SKIP CURRENT USER (IMPORTANT)
                      if (data["uid"] == currentUserId) {
                        return SizedBox();
                      }

                      return UserChat(
                        name: data["name"] ?? "Unknown",
                        imageUrl: data["photoUrl"] ?? "",
                        uid: data["uid"],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        thickness: 0.6,
                        color: Colors.grey.shade400,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserChat extends StatelessWidget {
  final String name;
  final String uid;
  final String imageUrl;

  const UserChat({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.uid,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25,
        backgroundImage: imageUrl.isNotEmpty
            ? NetworkImage(imageUrl)
            : null,
        child: imageUrl.isEmpty ? Icon(Icons.person) : null,
      ),

      title: Text(
        name,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),

      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ChatScreen(
              name: name,
              photoUrl: imageUrl,
              receiverId: uid,
            ),
          ),
        );
      },
    );
  }
}