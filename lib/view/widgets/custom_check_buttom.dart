import 'package:flutter/material.dart';

class CustomCheckButton extends StatelessWidget {
  final String title;
  final bool value;
  final void Function(bool?) onChanged;
  const CustomCheckButton({
    Key? key, 
    required this.value, 
    required this.onChanged, 
    required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(title, style: const TextStyle(
          overflow: TextOverflow.visible,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        )
      ),
      controlAffinity: ListTileControlAffinity.leading,
      value: value, 
      onChanged: onChanged,
    );
  }
}