import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:formulario_de_atendimento/data/data_access_object.dart';
import 'package:formulario_de_atendimento/view/screens/home_screen.dart';
import 'package:formulario_de_atendimento/view/screens/login_screen.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

class CustomLoginCheck extends StatelessWidget {
  const CustomLoginCheck({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Box userDataBox = GetIt.I.get<Box>(instanceName: DefaultBoxes.userData);
    final String? email = userDataBox.get('email') as String?;
    final String? name = userDataBox.get('name') as String?;

    if (EmailValidator.validate(email ?? '') && name != null && name.isNotEmpty) {
      return const HomeScreen();
    } else {
      return const LoginScreen();
    }
  }
}