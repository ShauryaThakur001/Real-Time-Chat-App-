import 'package:flutter/material.dart';
import 'package:flutter_application_1/Firebase/Auth/AuthGate.dart';
import 'package:flutter_application_1/Screens/Auth/loginScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _animation = Tween<double>(begin: 0.5, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();

    // Navigate after 2 seconds
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AuthGate()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

          Spacer(),

          // Slightly above center
          ScaleTransition(
            scale: _animation,
            child: Column(
              children: [

                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 8,
                        blurStyle: BlurStyle.outer,
                        color: Colors.black
                      )
                    ]
                  ),
                  child: Icon(
                    Icons.messenger,
                    color: Colors.white,
                    size: 50,
                  ),
                ),

                SizedBox(height: 20),

                Text(
                  "ChatModern",
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  "connect instantly",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ),

          Spacer(),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.lock_outline, color: Colors.grey, size: 17),
              SizedBox(width: 5),
              Text(
                "End-to-end encrypted",
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),

          SizedBox(height: 30),
        ],
      ),
    );
  }
}