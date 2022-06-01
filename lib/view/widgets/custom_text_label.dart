import 'package:flutter/material.dart';

class CustomTextLabel extends StatelessWidget {
  final String text;
  final double fontSize;
  final double margin;
  const CustomTextLabel(
    this.text, 
    {Key? key, 
    this.margin = 16, 
    this.fontSize = 20}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: margin),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}