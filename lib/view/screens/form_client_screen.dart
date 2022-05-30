import 'dart:io';

import 'package:flutter/material.dart';
import 'package:formulario_de_atendimento/view/screens/basic_information_cliente_form.dart';

class FormClientScreen extends StatefulWidget {
  final Directory downloadsDirectory;
  const FormClientScreen({Key? key, required this.downloadsDirectory}) : super(key: key);

  @override
  State<FormClientScreen> createState() => _FormClientScreenState();
}

class _FormClientScreenState extends State<FormClientScreen> {
  late final PageController pageController;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: currentPage);
  }

  void setCurrentPage(int page) {
    setState(() => currentPage = page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Formulário de Atendimento', 

          style: TextStyle(color: Theme.of(context).textTheme.titleLarge!.color ?? Colors.black),
        ),
        iconTheme: IconThemeData(
          color: Theme.of(context).textTheme.titleLarge!.color ?? Colors.black,
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: setCurrentPage,
        children: const <Widget>[
          BasocInformationsClienteForm()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment_ind_sharp),
              label: "Info. básicas",),
          BottomNavigationBarItem(
              icon: Icon(Icons.miscellaneous_services),
              label: "Serviços",),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: "Registos",),
        ],
        onTap: (page) {
          pageController.animateToPage(page,
              duration: const Duration(milliseconds: 450), curve: Curves.ease);
        },
      ),
    );
  }
}