import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool isVisible = false;
  bool isVisible2 = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          "Create Account",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),

                    Text(
                      "Join the \nConversation",
                      style: TextStyle(fontSize: 35),
                    ),

                    SizedBox(height: 10),

                    Text(
                      "Sign up to start chatting with your friends and family instantly",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w100,
                        fontSize: 17,
                      ),
                    ),

                    SizedBox(height: 25),

                    Text(
                      "Full Name",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 8),

                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        hintText: "Enter your full name",
                        hintStyle: TextStyle(color: Colors.grey.shade500),
                        prefixIcon: Icon(Icons.person, color: Colors.grey),
                      ),
                      validator: (value) {
                        if (nameController.text.isEmpty) {
                          return "Enter name";
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 18),

                    Text(
                      "Email Address",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 8),

                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        hintText: "name@example.com",
                        hintStyle: TextStyle(color: Colors.grey.shade500),
                        prefixIcon: Icon(Icons.email, color: Colors.grey),
                      ),
                      validator: (value) {
                        if (emailController.text.isEmpty ||
                            !passwordController.text.contains('@')) {
                          return "Enter correct email";
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 18),

                    Text(
                      "Password",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 8),

                    TextFormField(
                      obscureText: !isVisible,
                      controller: passwordController,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        hintText: "***************",
                        hintStyle: TextStyle(color: Colors.grey.shade500),
                        prefixIcon: Icon(Icons.lock, color: Colors.grey),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isVisible = !isVisible;
                            });
                          },
                          icon: isVisible
                              ? Icon(Icons.visibility, color: Colors.grey)
                              : Icon(Icons.visibility_off, color: Colors.grey),
                        ),
                      ),
                      validator: (value) {
                        if (passwordController.text.isEmpty ||
                            passwordController.text.length < 5) {
                          return "Password length should be greater than 5";
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 18),

                    Text(
                      "Confirm Password",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 8),

                    TextFormField(
                      obscureText: !isVisible2,
                      controller: confirmPasswordController,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        hintText: "***************",
                        hintStyle: TextStyle(color: Colors.grey.shade500),
                        prefixIcon: Icon(Icons.lock, color: Colors.grey),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isVisible2 = !isVisible2;
                            });
                          },
                          icon: isVisible2
                              ? Icon(Icons.visibility, color: Colors.grey)
                              : Icon(Icons.visibility_off, color: Colors.grey),
                        ),
                      ),
                      validator: (value) {
                        if (confirmPasswordController.text.isEmpty ||
                            passwordController.text.isEmpty) {
                          return "Password length should be greater than 5";
                        }
                        if (confirmPasswordController.text !=
                            passwordController.text) {
                          return "Password does not match";
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 25),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.symmetric(
                          horizontal: 150,
                          vertical: 12,
                        ),
                        elevation: 1,
                        shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          print("Sign Up Successful");
                        }
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),

                    SizedBox(height: 25),

                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an Account? "),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Sign In",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "© 2026 ChatApp Inc. All rights reserved",
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
