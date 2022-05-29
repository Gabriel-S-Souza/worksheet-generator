// ignore_for_file: unused_field, avoid_print, unnecessary_null_comparison

import 'dart:io';
import 'dart:typed_data';

import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show ByteData, PlatformException, rootBundle;
import 'package:permission_handler/permission_handler.dart';


class MyAppModel extends StatelessWidget {
  const MyAppModel({Key? key}) : super(key: key);

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
  PermissionStatus _permissionStatus = PermissionStatus.denied;
  late Directory _downloadsDirectory;

  @override
  void initState() {
    super.initState();
    _listenForPermission();
    initDownloadsDirectoryState();
  }

  Future<void> initDownloadsDirectoryState() async {
    Directory? downloadsDirectory;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      downloadsDirectory = await DownloadsPathProvider.downloadsDirectory;
    } on PlatformException {
      print('Could not get the downloads directory');
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _downloadsDirectory = downloadsDirectory!;
    });
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
    ByteData data = await rootBundle.load("assets/worksheets/template-tesoura.xlsx");
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
                'Atualizar "D6"',
              ),
              TextField(
                controller: _textEditingController,
                decoration: const InputDecoration(
                  hintText: 'H7',
                ),
              ),
              ElevatedButton(
                onPressed: () async {

                  excel.updateCell(
                    'TESOURA',
                     CellIndex.indexByString('G17'), 
                     _textEditingController.text,
                     cellStyle: CellStyle(
                       textWrapping: TextWrapping.WrapText,
                       horizontalAlign: HorizontalAlign.Center,
                       verticalAlign: VerticalAlign.Top,
                     )
                  );

                  final List<int> bytes = excel.encode()!;


                  Uint8List data = Uint8List.fromList(bytes);

                  await writeFile(data, 'teste3.xlsx');

                  _downloadsDirectory != null
                      ? print('downloadsDirectory: $_downloadsDirectory')
                      : print('downloadsDirectory: null');


                  // final fileBytes = excel.save(fileName: 'teste2.xlsx');

                  // final directory = await getApplicationDocumentsDirectory();
                  // print(directory.path);

                  // File(p.join(directory.path, 'teste2'))
                  //   ..createSync(recursive: true)
                  //   ..writeAsBytesSync(fileBytes!);
                  
                  // print('salvo');

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

  Future<File> writeFile(Uint8List data, String name) async {
    // storage permission ask
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    // the downloads folder path
    Directory tempDir = _downloadsDirectory;
    String tempPath = tempDir.path;
    var filePath = '$tempPath/$name';
    // 

    // the data
    var bytes = ByteData.view(data.buffer);
    final buffer = bytes.buffer;
    // save the data in the path
    return File(filePath).writeAsBytes(buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }
}
