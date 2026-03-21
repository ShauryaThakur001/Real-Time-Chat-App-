import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController searchCoontroller = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Icon(Icons.menu, color: Colors.blue, size: 30),
        centerTitle: true,
        title: Text("Contacts", style: TextStyle(fontSize: 25)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.blue.shade50,
              child: Icon(Icons.add, color: Colors.blue.shade700, size: 25),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          children: [
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
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text(
                        "No contacts found 👋",
                        style: TextStyle(color: Colors.grey),
                      ),
                    );
                  }

                  final users = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final data = users[index].data() as Map<String, dynamic>;

                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(data["photoUrl"] ?? ""),
                        ),
                        title: Text(data["name"] ?? "Unknown"),
                        subtitle: Text(data["email"] ?? ""),
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
