import 'package:flutter/material.dart';

class CustomTextArea extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputAction textInputAction;
  final Function()? onSubmitted;
  final void Function(String?) onChanged;
  const CustomTextArea({
    Key? key, 
    required this.hint, 
    required this.onChanged, 
    this.controller, 
    this.textInputAction = TextInputAction.next, 
    this.onSubmitted, 
    this.focusNode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxHeight: 200,
        minHeight: 130,
      ),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(32),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextFormField(
        focusNode: focusNode ?? FocusNode(),
        maxLines: null,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
        ),
        controller: controller,
        onChanged: onChanged,
        autofocus: false,
        textInputAction: textInputAction,
        onFieldSubmitted: (value) {
          onSubmitted?.call();
        },
      ),
    );
  }
}