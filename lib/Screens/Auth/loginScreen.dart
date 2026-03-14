import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey=GlobalKey();
  
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
            Container(
              height: 250,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                child: Image(fit: BoxFit.cover,image: AssetImage("assets/login.jpg"))),
            ),
            SizedBox(height: 20,),
            Text("Welcome Back",style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold
            ),),
            SizedBox(height: 7,),
            Text("Enter your details to access your chats",style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 19
            ),),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 20,),
                Text("Email Address",style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      hintText: "name@example.com",
                      hintStyle: TextStyle(color: Colors.grey.shade500),
                      prefixIcon: Icon(Icons.email,color: Colors.grey,)
                    ),
                    validator: (value) {
                      if(emailController.text.isEmpty || !emailController.text.contains('@')){
                        return "Enter Valid Email";
                      }
                    },
                  ),
                ),
                SizedBox(height: 10,),
                Text("Password",style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      hintText: "**********************",
                      hintStyle: TextStyle(color: Colors.grey.shade500),
                      prefixIcon: Icon(Icons.email,color: Colors.grey,)
                    ),
                    validator: (value) {
                      if(passwordController.text.isEmpty || passwordController.text.length<5){
                        return "Password length should be greater than 5";
                      }
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}