import 'package:flutter/material.dart';
import 'package:flutter_application_1/Firebase/Auth/EmailPasswordLogin.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            Emailpasswordlogin().logOut();
          }, icon: Icon(Icons.logout))
        ],
      ),
    );
  }
}