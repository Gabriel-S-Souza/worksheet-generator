import 'package:flutter/material.dart';

class FormClientScreen extends StatefulWidget {
  const FormClientScreen({Key? key}) : super(key: key);

  @override
  State<FormClientScreen> createState() => _FormClientScreenState();
}

class _FormClientScreenState extends State<FormClientScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de Atendimento'),
        centerTitle: true,
        elevation: 0,
      ),
      body: const Center(
        child: Text('Formulário de Atendimento'),
      ),
    );
  }
}