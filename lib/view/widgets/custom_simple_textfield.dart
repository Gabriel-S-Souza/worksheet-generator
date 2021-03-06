import 'package:flutter/material.dart';

class CustomSimpleTextField extends StatelessWidget {
  final String label;
  final String? hint;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? prefix;
  final TextInputAction? textInputAction;
  final TextInputType textInputType;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final String? Function(String?)? validator;
  const CustomSimpleTextField({
    Key? key, 
    required this.label, 
    this.hint, 
    this.controller, 
    this.keyboardType, 
    this.prefixIcon, 
    this.prefix, 
    this.textInputAction, 
    this.textInputType = TextInputType.text,
    this.onChanged, 
    this.onSubmitted, 
    this.validator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(28)),
        ),
        isDense: true,
        labelText: label,
        prefixIcon: prefixIcon,
        prefix: prefix,
      ),
      keyboardType: textInputType,
      textInputAction: TextInputAction.next,
      onChanged: onChanged,
      validator: validator,
      onFieldSubmitted: onSubmitted,
      textAlignVertical: TextAlignVertical.center,
    );
  }
}