import 'package:flutter/material.dart';

class CustomActionButtonGroup extends StatelessWidget {
  final Widget primaryChild;
  final Widget secondaryChild;
  final VoidCallback? onPrimaryPressed;
  final VoidCallback? onSecondaryPressed;
  const CustomActionButtonGroup({
    Key? key, 
    required this.primaryChild, 
    required this.secondaryChild, 
    this.onPrimaryPressed, 
    this.onSecondaryPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    return Align(
      widthFactor: deviceWidth,
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 48,
            child: OutlinedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  )
                )
              ),
              onPressed: onSecondaryPressed, 
              child: secondaryChild,
            ),
          ),
          const SizedBox(width: 16),
          SizedBox(
            height: 48,
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  )
                )
              ),
              onPressed: onPrimaryPressed, 
              child: primaryChild,
            ),
          ),
        ],
      ),
    );
  }
}