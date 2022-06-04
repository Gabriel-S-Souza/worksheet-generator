import 'package:flutter/material.dart';

class ServicesEquipmentScreen extends StatelessWidget {
  const ServicesEquipmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.05),
      child: SingleChildScrollView()
    );
  }
}