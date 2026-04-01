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

  // ✅ MOVE CONTROLLER HERE (not inside build)
  final TextEditingController searchController = TextEditingController();

  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    // ✅ Listen to search input
    searchController.addListener(() {
      setState(() {
        searchQuery = searchController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    searchController.dispose(); // ✅ important
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        leading: const Icon(Icons.menu, color: Colors.blue, size: 30),
        centerTitle: true,
        title: const Text("Contacts", style: TextStyle(fontSize: 25)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.blue.shade50,
              child: Icon(Icons.add,
                  color: Colors.blue.shade700, size: 25),
            ),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          children: [
            // 🔍 SEARCH FIELD
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                prefixIcon:
                    Icon(Icons.search, color: Colors.grey.shade600),
                hintText: "Search conversations",
                hintStyle:
                    TextStyle(color: Colors.grey.shade600),
                border:
                    const OutlineInputBorder(borderSide: BorderSide.none),
                fillColor: const Color(0xFFF0F8FF),
                filled: true,
              ),
            ),

            const SizedBox(height: 10),

            // 📄 USER LIST
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .snapshots(),
                builder: (context, snapshot) {

                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData ||
                      snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text(
                        "No contacts found 👋",
                        style: TextStyle(color: Colors.grey),
                      ),
                    );
                  }

                  final allUsers = snapshot.data!.docs;

                  // ✅ Filterss
                  final filteredUsers = allUsers.where((user) {
                    final data =
                        user.data() as Map<String, dynamic>;

                    final name =
                        (data["name"] ?? "").toString().toLowerCase();

                    return name.contains(searchQuery);
                  }).toList();

                  if (filteredUsers.isEmpty) {
                    return const Center(
                      child: Text(
                        "No matching users 😔",
                        style: TextStyle(color: Colors.grey),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: filteredUsers.length,
                    itemBuilder: (context, index) {
                      final data = filteredUsers[index].data()
                          as Map<String, dynamic>;

                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: data["photoUrl"] != null &&
                                  data["photoUrl"] != ""
                              ? NetworkImage(data["photoUrl"])
                              : null,
                          child: data["photoUrl"] == null ||
                                  data["photoUrl"] == ""
                              ? const Icon(Icons.person)
                              : null,
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