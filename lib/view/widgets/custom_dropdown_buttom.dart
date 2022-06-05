import 'package:flutter/material.dart';

class CustomDropdownButtom extends StatelessWidget {
  final String? value;
  final String hint;
  final List<String> items;
  final void Function(String?) onChanged;

  const CustomDropdownButtom({
    Key? key, 
    this.value,
    required this.hint, 
    required this.onChanged, 
    required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 4,
            spreadRadius: 1,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Text(
            hint,
            style: const TextStyle(
            fontWeight: FontWeight.bold
            ),
          ),
          value: value,
          isExpanded: true,
          style: Theme.of(context).textTheme.titleMedium,
          onChanged: onChanged,
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.bold
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}