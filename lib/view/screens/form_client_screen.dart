import 'dart:io';

import 'package:flutter/material.dart';
import 'package:formulario_de_atendimento/rules/spreadsheet_generator.dart';
import 'package:formulario_de_atendimento/view/screens/basic_information_cliente_form_screen.dart';
import 'package:formulario_de_atendimento/view/screens/services_client_form_screen.dart';
import 'package:get_it/get_it.dart';

import 'registers_client_form_screen.dart';

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
    GetIt.I.registerSingleton<SpreadsheetGenerator>(
      SpreadsheetGenerator(
        downloadsDirectory: widget.downloadsDirectory,
        spreadsheetName: 'formulario_de_atendimento',
        spredsheetTemplatePath: "assets/worksheets/template-cliente.xlsx"
      ),
      instanceName: 'client_form'
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    GetIt.I.reset();
    super.dispose();
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
        key: const PageStorageKey<String>('form_client'),
        controller: pageController,
        onPageChanged: setCurrentPage,
        children: <Widget>[
          BasicInformationsClienteFormScreen(
            onPrimaryPressed: () {
              animatePage(1);
            },
          ),
          ServicesClientFormScreen(
             onPrimaryPressed: () {
              animatePage(2);
            },
            onSecondaryPressed: () {
              animatePage(0);
            },
          ),
          RegistersClientFormScreen(
            onSecondaryPressed: () {
              animatePage(1);
            },
          ),
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
        onTap: animatePage,
      ),
    );
  }

  void animatePage(int page) {
    pageController.animateToPage(page, duration: const Duration(milliseconds: 450), curve: Curves.ease);
  }
}