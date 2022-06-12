import 'dart:developer';


import 'package:flutter/material.dart';
import 'package:formulario_de_atendimento/main.dart';
import 'package:formulario_de_atendimento/view/screens/equipment_form/equipment_form_screen.dart';
import 'package:formulario_de_atendimento/view/widgets/custom_app_buttom.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../data/data_access_object.dart';
import '../widgets/custom_dropdown_buttom.dart';
import '../widgets/custom_login_check.dart';
import 'client_form/form_client_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final UserSettings userSettings = GetIt.I.get<UserSettings>();
  PermissionStatus permissionStatus = PermissionStatus.denied;
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
        child: Stack(
          children: [
            Column(
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
                 child: CustomDropdownButtom(
                   hint: 'SELECIONE O EQUIPAMENTO',
                   value: value,
                   onChanged: (value) => setState(() => this.value = value),
                   items: equipment,
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
                                  return FormClientScreen();
                                } else {
                                  return EquipmentFormScreen(
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
            Positioned(
              bottom: 24,
              child: Column(
                children: [
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: deviceWidth - (deviceWidth * 0.05) * 2,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      userSettings.name ?? '',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold
                      )),
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxHeight: 34,
                    ),
                    child: TextButton(
                      onPressed: _unregisterUser, 
                      child: const Text(
                        'Sair',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _unregisterUser() async {
    Box<dynamic> userDataBox = GetIt.I.get<Box<dynamic>>(instanceName: DefaultBoxes.userData);
    
    await userDataBox.put('email', '');
    await userDataBox.put('name', '');

    GetIt.I.unregister<UserSettings>();
    
    if (mounted) {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => const CustomLoginCheck(),
      ));
    }
    
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

  // Future<void> _initDownloadsDirectoryState() async {
  //   String? directory;

  //   try {
  //     directory = await AndroidPathProvider.downloadsPath;
  //   } on PlatformException {
  //     throw Exception('Could not get the downloads directory');
  //   }

  //   if (!mounted) return;

  //   setState(() {
  //     downloadsDirectory = directory!;
  //   });
  // }

}