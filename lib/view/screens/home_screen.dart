import 'dart:developer';


import 'package:android_path_provider/android_path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:formulario_de_atendimento/view/screens/equipment_form/equipment_form_screen.dart';
import 'package:formulario_de_atendimento/view/widgets/custom_app_buttom.dart';
import 'package:permission_handler/permission_handler.dart';

import 'client_form/form_client_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PermissionStatus permissionStatus = PermissionStatus.denied;
  // late Directory downloadsDirectory;
  late String downloadsDirectory;
  String? value;
  final List<String> equipment = [
    'TESOURA VTN 4000',
    'TESOURA INDECO 45/90',
    'TESOURA INDECO 35/60',
    'TESOURA LABOUNTY MSD-2500',
    'TESOURA LABOUNTY MSD-4000',
    'OUTRO'
  ];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _listenForPermission();
    _initDownloadsDirectoryState();
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;

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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, deviceWidth * 0.2),
                alignment: Alignment.topCenter,
                child: Image.asset(
                  'assets/images/logo.png',
                  width: deviceWidth * 0.6,
                ),
              ),
            ),
            Flexible(
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    hint: const Text(
                      'SELECIONE O EQUIPAMENTO',
                         style: TextStyle(
                          fontWeight: FontWeight.bold
                        ),
                    ),
                    
                    value: value,
                    isExpanded: true,
                    style: Theme.of(context).textTheme.titleMedium,
                    onChanged: (value) => setState(() => this.value = value),
                    items: equipment.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            SizedBox( height: deviceHeight * 0.05),
            Flexible(
              child: CustomAppButtom(
                onPressed: !isLoading
                      ? () {
                    if(value != null) {
                      setState(() => isLoading = true);
                      Navigator.push(
                        context, MaterialPageRoute(
                          builder: (context) {
                            if(value == 'OUTRO') {
                              return FormClientScreen(downloadsDirectory: downloadsDirectory);
                            } else {
                              return EquipmentFormScreen(
                                downloadsDirectory: downloadsDirectory, 
                                equipmentName: value ?? 'Erro ao selecionar o equipamento',
                              );
                            }
                          }
                        )
                      ).then((value) => setState(() => isLoading = false));
                    }
                  }
                      : null,
                child: !isLoading
                  ? const Text('IR PARA O FORMULÁRIO')
                  : const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.white,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _listenForPermission() async {
    final status = await Permission.storage.status;
    setState(() {
      permissionStatus = status;
    });

    switch (status) {
      case PermissionStatus.denied:
        _requestForPermission();
        break;
      case PermissionStatus.granted:
        log('granted');
        break;
      case PermissionStatus.limited:
        log('limited');
        break;
      case PermissionStatus.restricted:
        log('restricted');
        break;
      case PermissionStatus.permanentlyDenied:
        log('permanently denied');
        break;

      default:
    }
   }
  
  Future<void> _requestForPermission() async {
     final status = await Permission.storage.request();
     setState(() {
        permissionStatus = status;
     });
  }

  Future<void> _initDownloadsDirectoryState() async {
    String? directory;

    try {
      directory = await AndroidPathProvider.downloadsPath;
    } on PlatformException {
      throw Exception('Could not get the downloads directory');
    }

    if (!mounted) return;

    setState(() {
      downloadsDirectory = directory!;
    });
  }

}