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
  final void Function(dynamic) onSuggestionSelected;
  final FutureOr<Iterable<dynamic>> Function(String) suggestionsCallback;
  final Widget Function(BuildContext, dynamic) itemBuilder;
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
    this.textInputAction = TextInputAction.next}) : super(key: key);

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
            controller: controller,
            obscureText: obscure,
            keyboardType: textInputType,
            textInputAction: textInputAction,
            onChanged: onChanged,
            enabled: enabled,
            autofocus: false,
            onSubmitted: (value) {
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
        )
      ),
    );
  }
}