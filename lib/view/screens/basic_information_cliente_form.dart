import 'package:flutter/material.dart';

import '../widgets/custom_buttom_header.dart';
import '../widgets/custom_text_label.dart';

class BasocInformationsClienteForm extends StatelessWidget {
  const BasocInformationsClienteForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.05),
      child: ListView(
        children:  <Widget>[
          const CustomTextLabel('Data'),
          CustomButtomHeader(
            child: const Icon(Icons.calendar_month),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}