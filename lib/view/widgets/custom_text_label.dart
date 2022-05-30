import 'package:flutter/material.dart';

class CustomTextLabel extends StatelessWidget {
  final String text;
  const CustomTextLabel(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}