import 'package:auth_app/pages/login.dart';
import 'package:auth_app/pages/signup_page.dart';
import 'package:flutter/material.dart';

class LoginRegisterPage extends StatefulWidget {
  LoginRegisterPage({super.key});

  @override
  State<LoginRegisterPage> createState() => _LoginRegisterPageState();
}

class _LoginRegisterPageState extends State<LoginRegisterPage> {
  bool showLoginPage = true;

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginScreen(onTap: togglePages,);
    } else {
      return SignupScreen(onTap: togglePages,);
    }
  }
}
