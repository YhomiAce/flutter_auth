// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:auth_app/components/custom_button.dart';
import 'package:auth_app/components/input_textfield.dart';
import 'package:auth_app/components/square_tile.dart';
import 'package:auth_app/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  Function() onTap;
  SignupScreen({required this.onTap});
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

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
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: Text(
              message,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }

  void register() async {
    // add validation
    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      displayMessage('Please fill all fields');
      return;
    } else if (passwordController.text != confirmPasswordController.text) {
      displayMessage('Passwords do not match');
      return;
    }
    // show loading circle
    displayLoader();

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'weak-password') {
        displayMessage('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        displayMessage('The account already exists for that email.');
      }
    } catch (e) {
      displayMessage(e.toString());
    } finally {
      Navigator.pop(context);
    }
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
                'Welcome To Meal Market!',
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
              // confirm password textfield
              InputTextField(
                hintText: 'Confirm Password',
                obsecureText: true,
                controller: confirmPasswordController,
              ),

              spacer(25),
              // sign in button
              CustomButton(
                title: "Sign Up",
                onTap: register,
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
                        'Or signup with',
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
                  SquareTile(imagePath: 'assets/images/google.png'),
                  SizedBox(
                    width: 25,
                  ),
                  // apple button
                  SquareTile(imagePath: 'assets/images/apple.png'),
                ],
              ),
              spacer(),
              // not a member? register
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: TextStyle(
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
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
