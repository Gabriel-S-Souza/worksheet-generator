

import 'dart:io';

import 'package:excel/excel.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Meu formulário'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _textEditingController = TextEditingController();
  late Excel excel;
  late Permission _permission;
  PermissionStatus _permissionStatus = PermissionStatus.denied;

  @override
  void initState() {
    super.initState();
    _listenForPermission();
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

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    ByteData data = await rootBundle.load("assets/worksheets/teste2.xlsx");
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    excel = Excel.decodeBytes(bytes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Atualizar "B2"',
              ),
              TextField(
                controller: _textEditingController,
                decoration: const InputDecoration(
                  hintText: 'B2',
                ),
              ),
              ElevatedButton(
                onPressed: () async {

                  excel.updateCell('Página1', CellIndex.indexByString('B3'), _textEditingController.text);

                  

                  final fileBytes = excel.save(fileName: 'teste.xlsx');

                  final directory = await getApplicationDocumentsDirectory();

                  File(p.join(directory.path, 'teste.xlsx'))
                    ..createSync(recursive: true)
                    ..writeAsBytesSync(fileBytes!);
                  

                }, 
                child: const Text('Atualizar'),
              ),
              ElevatedButton(
                onPressed: () async {
                    
                for (var table in excel.tables.keys) {
                  print(table); //sheet Name
                  print(excel.tables[table]?.maxCols);
                  print(excel.tables[table]?.maxRows);
                  for (var row in excel.tables[table]!.rows) {
                    for (var cell in row) {
                      print(cell?.value ?? 'sem valor');
                    }
                  }
                }
                }, 
                child: const Text('Print planilha'),
              )
            ],
          ),
        ),
      ),
    );
  }

}
