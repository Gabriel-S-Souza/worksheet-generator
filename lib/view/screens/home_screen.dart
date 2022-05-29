import 'dart:io';

import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PermissionStatus _permissionStatus = PermissionStatus.denied;
  late Directory _downloadsDirectory;

  @override
  void initState() {
    super.initState();
    _listenForPermission();
    _initDownloadsDirectoryState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de Atendimento'),
        centerTitle: true,
        elevation: 14,
      ),
      body: const Text('HomeScreen'),
    );
  }

  void _listenForPermission() async {
    final status = await Permission.storage.status;
    setState(() {
      _permissionStatus = status;
    });

    switch (status) {
      case PermissionStatus.denied:
        _requestForPermission();
        break;
      case PermissionStatus.granted:
        print('granted');
        break;
      case PermissionStatus.limited:
        print('limited');
        break;
      case PermissionStatus.restricted:
        print('restricted');
        break;
      case PermissionStatus.permanentlyDenied:
        print('permanently denied');
        break;

      default:
    }
   }
  
  Future<void> _requestForPermission() async {
     final status = await Permission.storage.request();
     setState(() {
        _permissionStatus = status;
     });
  }

  Future<void> _initDownloadsDirectoryState() async {
    Directory? downloadsDirectory;

    try {
      downloadsDirectory = await DownloadsPathProvider.downloadsDirectory;
    } on PlatformException {
      throw Exception('Could not get the downloads directory');
    }

    if (!mounted) return;

    setState(() {
      _downloadsDirectory = downloadsDirectory!;
    });
  }

}