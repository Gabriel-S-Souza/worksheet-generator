import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:formulario_de_atendimento/view/screens/home_screen.dart';
import 'package:formulario_de_atendimento/view/screens/login_screen.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../data/data_access_object.dart';
import '../../main.dart';

class CustomLoginCheck extends StatelessWidget {
  const CustomLoginCheck({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final Box userDataBox = GetIt.I.get<Box>(instanceName: DefaultBoxes.userData);

    final String? email = userDataBox.get('email');
    final String? name = userDataBox.get('name');

    if (EmailValidator.validate(email ?? '') && name != null && name.isNotEmpty) {
      final UserSettings userSettings;

      userSettings = UserSettings(
        email: userDataBox.get('email'),
        name: userDataBox.get('name'),
      );
      print('fora');

      if (!GetIt.I.isRegistered<UserSettings>()) {
        print('Registering user settings');
        GetIt.I.registerSingleton<UserSettings>(userSettings);
      }

      return const HomeScreen();
    } else {
      return const LoginScreen();
    }
  }
}