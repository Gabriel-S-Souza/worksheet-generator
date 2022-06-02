import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:formulario_de_atendimento/view/screens/home_screen.dart';
import 'package:formulario_de_atendimento/view/screens/login_screen.dart';
import 'package:get_it/get_it.dart';

import '../../main.dart';

class CustomLoginCheck extends StatelessWidget {
  const CustomLoginCheck({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserSettings userSettings = GetIt.I.get<UserSettings>();
    final String? email = userSettings.email;
    final String? name = userSettings.name;

    if (EmailValidator.validate(email ?? '') && name != null && name.isNotEmpty) {
      return const HomeScreen();
    } else {
      return const LoginScreen();
    }
  }
}