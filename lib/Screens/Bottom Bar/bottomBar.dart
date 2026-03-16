import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/Call%20Screen/callScreen.dart';
import 'package:flutter_application_1/Screens/Home%20Screen/homeScreen.dart';
import 'package:flutter_application_1/Screens/People%20Screen/PeopleScreen.dart';
import 'package:flutter_application_1/Screens/Setting%20Screen/SettingScreen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  int currentIndex = 0;

  List<Widget> pages = [
    HomeScreen(),
    CallScreen(),
    ContactsScreen(),
    SettingScreen(),
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex=value;
          });
        },
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.blue,
        selectedLabelStyle: TextStyle(color: Colors.blue),
        unselectedLabelStyle: TextStyle(color: Colors.red),
        showUnselectedLabels: true,
        items: [
        BottomNavigationBarItem(icon: Icon(Icons.chat),label: "Chats"),
        BottomNavigationBarItem(icon: Icon(Icons.call),label: "Calls"),
        BottomNavigationBarItem(icon: Icon(Icons.person_search_rounded),label: "Contacts"),
        BottomNavigationBarItem(icon: Icon(Icons.settings),label: "Settings"),
      ]),
    );
  }
}