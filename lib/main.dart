import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;

void main() async {
  runApp(const MyApp());

  ByteData data = await rootBundle.load("assets/worksheets/teste.xlsx");
  var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  var excel = Excel.decodeBytes(bytes);
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

                }, 
                child: const Text('Atualizar'),
              ),
              ElevatedButton(
                onPressed: () async {
                
                
                    
                for (var table in excel.tables.keys) {
                  for (var row in excel.tables[table]!.rows) {
                    print("${row}");
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
