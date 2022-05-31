import 'package:flutter/material.dart';

class CustomRadioButtonGroup extends StatefulWidget {
  final List<String> items;
  final String initialValue;
  final void Function(String?) onChanged;
  const CustomRadioButtonGroup({Key? key, 
  required this.items,
  required this.onChanged, 
  required this.initialValue}) : super(key: key);

  @override
  State<CustomRadioButtonGroup> createState() => _CustomRadioButtonGroupState();
}

class _CustomRadioButtonGroupState extends State<CustomRadioButtonGroup> {
  late String _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
  }

  Widget _buildRadioButton(BuildContext context, String item) {
    return SizedBox(
      child: RadioListTile<String>(
        contentPadding: const EdgeInsets.only(left: 16),
        value: item,
        groupValue: _selectedValue,
        visualDensity: VisualDensity.compact,
        onChanged: (newValue) => setState(() => _selectedValue = newValue!),
        title: Text(
          item,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          )
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      childAspectRatio: 1 / 0.3,
      crossAxisCount: 2,
      physics: const ScrollPhysics(parent: NeverScrollableScrollPhysics()),
      shrinkWrap: true,
      children: <Widget>[
        for (final item in widget.items)
          _buildRadioButton(context, item),
      ],
    );
  }
}