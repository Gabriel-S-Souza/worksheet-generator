import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class CustomSuggestionTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hint;
  final Widget? prefix;
  final Widget? suffix;
  final bool obscure;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final Function(String) onChanged;
  final Function()? onSubmitted;
  final void Function(bool)? onFocusChange;
  final bool enabled;
  final FocusNode? focusNode;
  final void Function(dynamic) onSuggestionSelected;
  final FutureOr<Iterable<dynamic>> Function(String) suggestionsCallback;
  final Widget Function(BuildContext, dynamic) itemBuilder;
  final TextStyle? style;
  final EdgeInsetsGeometry? contentPadding;
  const CustomSuggestionTextField({
    Key? key, 
    this.controller, 
    this.hint, 
    this.prefix, 
    this.suffix, 
    required this.obscure, 
    this.textInputType = TextInputType.text, 
    required this.onChanged, 
    this.onSubmitted, 
    this.onFocusChange, 
    this.enabled = true, 
    required this.onSuggestionSelected, 
    required this.suggestionsCallback, 
    required this.itemBuilder, 
    this.textInputAction = TextInputAction.next, 
    this.style, 
    this.contentPadding, 
    this.focusNode}) : super(key: key);

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
        child: TypeAheadFormField(
          onSuggestionSelected:onSuggestionSelected,
          suggestionsCallback: suggestionsCallback,
          itemBuilder: itemBuilder,
          textFieldConfiguration: TextFieldConfiguration(
            focusNode: focusNode ?? FocusNode(),
            controller: controller,
            obscureText: obscure,
            keyboardType: textInputType,
            textInputAction: textInputAction,
            onChanged: onChanged,
            enabled: enabled,
            autofocus: false,
            style: style,
            onSubmitted: (value) {
              onSubmitted?.call();
            },
            decoration: InputDecoration(
              contentPadding: contentPadding,
              hintText: hint,
              border: InputBorder.none,
              prefixIcon: prefix,
              suffixIcon: suffix,
            ),
            textAlignVertical: TextAlignVertical.center,
          ),
        )
      ),
    );
  }
}