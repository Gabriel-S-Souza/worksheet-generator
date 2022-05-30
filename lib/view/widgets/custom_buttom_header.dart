import 'package:flutter/material.dart';

class CustomButtomHeader extends StatefulWidget {
  final Widget child;
  final VoidCallback onPressed;
  const CustomButtomHeader({Key? key, required this.child, required this.onPressed}) : super(key: key);

  @override
  State<CustomButtomHeader> createState() => _CustomButtomHeaderState();
}

class _CustomButtomHeaderState extends State<CustomButtomHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Colors.grey,
        ),
        ),
      child: OutlinedButton(
        onPressed: widget.onPressed, 
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
              side: const BorderSide(color: Colors.black),
            )
        )
      ),
        child: widget.child,
      ),
    );
  }
}