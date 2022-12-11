// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Color;
  final textColor;
  final buttonBorder;
  final String buttonText;
  final buttonTapped;

  const MyButton(
      {super.key,
      this.Color,
      this.textColor,
      required this.buttonText,
      this.buttonTapped, 
      this.buttonBorder});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTapped,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Color,
            border: buttonBorder,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              buttonText,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
