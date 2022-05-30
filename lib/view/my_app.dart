import 'package:flutter/material.dart';
import 'package:formulario_de_atendimento/view/widgets/custom_login_check.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formulário de Atendimento',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      ),
      home: const CustomLoginCheck(),
    );
  }
}