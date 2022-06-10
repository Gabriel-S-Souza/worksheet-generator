import 'package:flutter/material.dart';

class CustomTextLabel extends StatelessWidget {
  final String text;
  final double fontSize;
  final double marginTop;
  final double marginBottom;
  final Color? color;
  const CustomTextLabel(
    this.text, 
    {Key? key, 
    this.marginTop = 22, 
    this.marginBottom = 16,
    this.fontSize = 20, 
    this.color,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: marginTop, bottom: marginBottom),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: color
        ),
      ),
    );
  }
}