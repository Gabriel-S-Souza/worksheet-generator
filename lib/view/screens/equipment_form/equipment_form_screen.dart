import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'basic_informations_equipment_screen.dart';
import 'registers_equipment_screen.dart';
import 'services_equipment_screen.dart';

class EquipmentFormScreen extends StatefulWidget {
  final String downloadsDirectory;
  final String equipmentName;
  const EquipmentFormScreen({Key? key, required this.downloadsDirectory, required this.equipmentName}) : super(key: key);

  @override
  State<EquipmentFormScreen> createState() => _EquipmentFormScreenState();
}

class _EquipmentFormScreenState extends State<EquipmentFormScreen> {
  late final PageController pageController;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: currentPage);
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
        title: AutoSizeText(
          widget.equipmentName,
          maxLines: 1, 
          style: TextStyle(
            color: Theme.of(context).textTheme.titleLarge!.color ?? Colors.black),
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
        children: <Widget>[
          BasicInformationsEquipmentScreen(
            onPrimaryPressed: () {
              animatePage(1);
            },
          ),
          ServicesEquipmentScreen(
            onPrimaryPressed: () {
              animatePage(2);
            },
            onSecondaryPressed: () {
              animatePage(0);
            },
          ),
          RegistersEquipmentScreen(
            onSecondaryPressed: () {
              animatePage(1);
              print('onSecondaryPressed');
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