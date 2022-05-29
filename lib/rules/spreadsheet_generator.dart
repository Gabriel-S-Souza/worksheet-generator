import 'dart:io';
import 'dart:typed_data';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show ByteData, PlatformException, rootBundle;
import 'package:permission_handler/permission_handler.dart';

class SpreadsheetGenerator {
  final String spredsheetTemplatePath;
  final String spreadsheetName;
  final Directory downloadsDirectory;
  SpreadsheetGenerator({
    required this.spredsheetTemplatePath,
    required this.spreadsheetName,
    required this.downloadsDirectory
  }) {
    _getSpreadsheet(spredsheetTemplatePath);
  }
  
  late final Excel _excel;

  //TODO: needs to be tested
  /// Updates the cell
  void updateCell(
    String sheetName,
    CellIndex cellIndex,
    dynamic value, {
    CellStyle? cellStyle,
    }) {
      _excel.updateCell(
        sheetName,
        cellIndex,
        value,
        cellStyle: cellStyle,
      );
  }

  // TODO: needs to be implemented
  Future<void> sendByEmail() async {}


  //TODO: needs to be tested
  /// Save the spreadsheet to the downloads directory and return the path.
  Future<String> exportFile() async {
    final List<int> bytes = _excel.encode()!;

    Uint8List data = Uint8List.fromList(bytes);

    await _writeFile(data, '${spreadsheetName}_${UniqueKey().toString().substring(2, 7)}.xlsx');

    return downloadsDirectory.path;
  }

  //TODO: needs to be tested
  /// Write the file to the downloads directory.
  Future<File> _writeFile(Uint8List data, String name) async {

    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }

    Directory tempDir = downloadsDirectory;
    String tempPath = tempDir.path;
    var filePath = '$tempPath/$name';

    var bytes = ByteData.view(data.buffer);
    final buffer = bytes.buffer;

    return File(filePath).writeAsBytes(buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }
  
  // /// Get the downloads directory.
  // Future<void> _initDownloadsDirectoryState() async {
  //   Directory? downloadsDirectory;
  //   try {
  //     downloadsDirectory = await DownloadsPathProvider.downloadsDirectory;
  //   } on PlatformException {
  //     throw Exception('Could not get the downloads directory');
  //   }
  //   if(downloadsDirectory != null) {
  //     _downloadsDirectory = downloadsDirectory;
  //   }
  // }
  
  /// Get the spreadsheet from the path.
  Future<void> _getSpreadsheet(String path) async {
    ByteData data = await rootBundle.load(path);
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    _excel = Excel.decodeBytes(bytes);
  }
}