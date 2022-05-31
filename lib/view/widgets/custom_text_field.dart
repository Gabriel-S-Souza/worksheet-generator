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
    this.onFocusChange, 
    this.onSubmitted, 
    this.textInputAction = TextInputAction.next,
  }) : super(key: key);
  final TextEditingController? controller;
  final String? hint;
  final Widget? prefix;
  final Widget? suffix;
  final bool obscure;
  final TextInputAction textInputAction;
  final TextInputType? textInputType;
  final Function(String) onChanged;
  final Function()? onSubmitted;
  final void Function(bool)? onFocusChange;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(32),
      ),
      padding: prefix != null ? null : const EdgeInsets.only(left: 16),
      child: Focus(
        onFocusChange: onFocusChange,
        child: TextFormField(
          controller: controller,
          obscureText: obscure,
          keyboardType: textInputType,
          onChanged: onChanged,
          enabled: enabled,
          autofocus: false,
          textInputAction: textInputAction,
          onFieldSubmitted: (value) {
            if (value.isNotEmpty) {
              onSubmitted?.call();
            }
          },
          decoration: InputDecoration(
            hintText: hint,
            border: InputBorder.none,
            prefixIcon: prefix,
            suffixIcon: suffix,
          ),
          textAlignVertical: TextAlignVertical.center,
        ),
      ),
    );
  }
}