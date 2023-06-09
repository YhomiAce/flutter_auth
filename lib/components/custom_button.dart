// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function() onTap;
  final String title;
  const CustomButton({required this.onTap, required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(25),
        margin: EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.black,
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
