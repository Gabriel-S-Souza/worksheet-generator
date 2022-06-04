import 'package:flutter/material.dart';

class CustomOutlinedButtom extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  const CustomOutlinedButtom({
    Key? key, 
    required this.child, 
    this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: OutlinedButton(
          style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            )
          )
        ),
        onPressed: onPressed,
        child: child,
      )
    );
  }
}