import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:formulario_de_atendimento/controllers/login_controller.dart';
import 'package:formulario_de_atendimento/view/widgets/custom_login_check.dart';
import 'package:formulario_de_atendimento/view/widgets/custom_simple_textfield.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final loginController = LoginController();

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de Atendimento'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, deviceWidth * 0.2),
              alignment: Alignment.topCenter,
              child: Image.asset(
                'assets/images/logo.png',
                width: deviceWidth * 0.5,
              ),
            ),
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomSimpleTextField(
                      label: 'Nome',
                      prefixIcon: const Icon(Icons.person),
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    onChanged: loginController.setName,
                    validator: (value) {
                      if (!loginController.isNameValid) {
                        return 'Insira seu nome';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomSimpleTextField(
                    label: 'Email',
                    prefixIcon: const Icon(Icons.email_outlined),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                    onChanged: loginController.setEmail,
                    validator: (value) {
                      if(!loginController.isEmailValid) {
                        return 'Email inválido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 36),
                  SizedBox(
                    height: 44,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          )
                        )
                      ),
                      child: const Text('Entrar'),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          await loginController.login();
                          
                          if (!mounted) return;

                          _buildSnackBar(context);

                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) => const CustomLoginCheck(),
                          ));
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ),
    );
  }

  void _buildSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        margin: EdgeInsets.only(bottom: 60),
        duration: Duration(milliseconds: 2500),
        behavior: SnackBarBehavior.floating,
        content: Text('Usuário registrado'),
      ),
    );
  }
}