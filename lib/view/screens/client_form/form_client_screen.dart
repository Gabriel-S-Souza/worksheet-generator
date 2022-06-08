import 'package:flutter/material.dart';
import 'package:formulario_de_atendimento/pdf/spreadsheet_xlsx_generator.dart';
import 'package:get_it/get_it.dart';

import 'basic_information_cliente_form_screen.dart';
import 'registers_client_form_screen.dart';
import 'services_client_form_screen.dart';


class FormClientScreen extends StatefulWidget {
  final String downloadsDirectory;
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
    GetIt.I.registerSingleton<SpreadsheetXlsxGenerator>(
      SpreadsheetXlsxGenerator(
        downloadsDirectory: widget.downloadsDirectory,
        spredsheetTemplatePath: "assets/worksheets/template-cliente.xlsx"
      ),
      instanceName: 'client_form'
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    GetIt.I.unregister<SpreadsheetXlsxGenerator>(instanceName: 'client_form');
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
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () => Navigator.maybePop(context),
        ),
      ),
      body: PageView(
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
            downloadsDirectory: widget.downloadsDirectory,
            onSecondaryPressed: () {
              animatePage(1);
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
        elevation: 0,
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