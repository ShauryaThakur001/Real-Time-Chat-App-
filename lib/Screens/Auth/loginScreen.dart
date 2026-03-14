import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isVisible = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      // appBar: AppBar(
      //   title: Text("Login",style: TextStyle(
      //     fontWeight: FontWeight.bold,
      //     fontSize: 27
      //   ),),
      //   centerTitle: true,
      // ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            SizedBox(height: 25),

            Container(
              height: 250,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                child: Image(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/login.jpg"),
                ),
              ),
            ),

            SizedBox(height: 25),

            Text(
              "Welcome Back",
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 10),

            Text(
              "Enter your details to access your chats",
              style: TextStyle(color: Colors.grey.shade600, fontSize: 19),
            ),

            SizedBox(height: 25),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Email Address",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                ),

                SizedBox(height: 18),

                Text(
                  "Password",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),

                SizedBox(height: 8),

                TextFormField(
                  obscureText: !isVisible,
                  controller: passwordController,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    hintText: "**********************",
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
                  onPressed: () {},
                  child: Text(
                    "Sign In",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),

                SizedBox(height: 25),

                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey.shade300)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        "Or continue with",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.grey.shade300)),
                  ],
                ),

                SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                      onPressed: () {},
                      child: Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            child: Image(
                              image: AssetImage("assets/google.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 8),
                          Text("Google", style: TextStyle(fontSize: 17)),
                        ],
                      ),
                    ),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                      onPressed: () {},
                      child: Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            child: Image(
                              image: NetworkImage(
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvx-tnpnt7x-68DU2UMFpvBamlIZY5VLtSKQ&s",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 8),
                          Text("Twitter", style: TextStyle(fontSize: 17)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),

            Spacer(),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an Account? "),
                Text("Create an account", style: TextStyle(color: Colors.blue)),
              ],
            ),

            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
