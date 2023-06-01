// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:auth_app/components/custom_button.dart';
import 'package:auth_app/components/input_textfield.dart';
import 'package:auth_app/components/square_tile.dart';
import 'package:auth_app/pages/signup_page.dart';
import 'package:auth_app/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  Function() onTap;
  LoginScreen({required this.onTap});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  void displayLoader() {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  void displayMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: TextStyle(
          color: Colors.redAccent,
        ),
      ),
      duration: Duration(
        seconds: 3,
      ),
    ));
  }

  void signUserIn() async {
    // add validation
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      displayMessage('Please fill all fields');
      return;
    }
    // show loading circle
    displayLoader();

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        displayMessage('Invalid Credential');
      } else if (e.code == 'wrong-password') {
        displayMessage('Invalid Password');
      }
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              spacer(20),
              // logo
              Icon(
                Icons.lock,
                size: 100,
              ),
              spacer(30),
              // welcome back

              Text(
                'Welcome back you\'ve been missed!',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),
              spacer(25),
              // Username textfield
              InputTextField(
                hintText: 'Username',
                controller: emailController,
              ),
              spacer(10),
              // password textfield
              InputTextField(
                hintText: 'Password',
                obsecureText: true,
                controller: passwordController,
              ),
              spacer(10),
              // forgot password
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                  ],
                ),
              ),
              spacer(25),
              // sign in button
              CustomButton(
                onTap: signUserIn,
                title: 'Sign In',
              ),
              spacer(),
              // or continue with
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
              spacer(),
              // google + apple sign in button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // google button
                  SquareTile(
                    imagePath: 'assets/images/google.png',
                    onTap: () {
                      AuthService().signInWithGoogle();
                    },
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  // apple button
                  SquareTile(
                    imagePath: 'assets/images/apple.png',
                    onTap: () {},
                  ),
                ],
              ),
              spacer(),
              // not a member? register
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not a member?',
                    style: TextStyle(
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                      'Register now',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

Widget spacer([double? space]) {
  return SizedBox(
    height: space ?? 50,
  );
}
