import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.onChanged,
    this.hint,
    this.prefix,
    this.suffix,
    this.obscure = false,
    this.textInputType,
    this.enabled,
    this.controller, 
    this.onSubmitted, 
    this.textInputAction = TextInputAction.next, 
    this.focusNode, 
    this.readOnly = false, 
    this.contentPadding, 
    this.style,
  }) : super(key: key);
  final TextEditingController? controller;
  final String? hint;
  final Widget? prefix;
  final Widget? suffix;
  final FocusNode? focusNode;
  final bool obscure;
  final TextInputAction textInputAction;
  final TextInputType? textInputType;
  final Function(String) onChanged;
  final Function()? onSubmitted;
  final bool? enabled;
  final bool readOnly;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(32),
      ),
      padding: prefix != null ? null : const EdgeInsets.only(left: 16),
      child: TextFormField(
        focusNode: focusNode,
        controller: controller,
        obscureText: obscure,
        keyboardType: textInputType,
        onChanged: onChanged,
        enabled: enabled,
        autofocus: false,
        readOnly: readOnly,
        textInputAction: textInputAction,
        onFieldSubmitted: (value) {
          onSubmitted?.call();
        },
        style: style,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          prefixIcon: prefix,
          suffixIcon: suffix,
          contentPadding: contentPadding,
        ),
        textAlignVertical: TextAlignVertical.center,
      ),
    );
  }
}