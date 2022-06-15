import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../controllers/client_form/general_client_controller.dart';
import 'basic_information_cliente_form_screen.dart';
import 'registers_client_form_screen.dart';
import 'services_client_form_screen.dart';


class FormClientScreen extends StatefulWidget {
  const FormClientScreen({Key? key}) : super(key: key);

  @override
  State<FormClientScreen> createState() => _FormClientScreenState();
}

class _FormClientScreenState extends State<FormClientScreen> {
  final GeneralClientController generalClientController = GetIt.I.get<GeneralClientController>();
  late final PageController pageController;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: currentPage);
    generalClientController.reset();
  }

  @override
  void dispose() {
    pageController.dispose();
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
              icon: Icon(Icons.assignment_turned_in),
              label: "Atendimento",),
        ],
        onTap: animatePage,
      ),
    );
  }

  void animatePage(int page) {
    pageController.animateToPage(page, duration: const Duration(milliseconds: 450), curve: Curves.ease);
  }
}