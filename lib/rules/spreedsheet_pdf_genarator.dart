import 'dart:io';

import 'dart:typed_data';
import 'package:flutter/services.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class SpreadsheetPdfGenerator {
  final Directory downloadsDirectory;
  SpreadsheetPdfGenerator(this.downloadsDirectory);

  final double cellHeight = 22;
  final double fontLargeSize = 16;
  final double fontMediumSize = 10;
  final double fontSmallSize = 8;
  
  clientSheetCreate() async {
    const String name = 'teste.pdf';
    final ByteData bytes = await rootBundle.load('assets/images/logo.png');
    final Uint8List byteList = bytes.buffer.asUint8List();

    Directory tempDir = downloadsDirectory;
    String tempPath = tempDir.path;
    var filePath = '$tempPath/$name';

    final pdf = pw.Document();
    pdf.addPage(
      pw.MultiPage(
        margin: const pw.EdgeInsets.symmetric(horizontal: 18, vertical: 22),
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        mainAxisAlignment: pw.MainAxisAlignment.start,
        pageFormat: PdfPageFormat.a4,
        build: (context) => [
          _contentHeader(context, byteList, 'RELATÓRIO DE ATENDIMENTO', 'XXXXX', '00/00/0000'),
          _contentBasicInfo(context),
          _contentServices(context),
          _termsRegisters(context),
        ], 
      ),
    );

    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());
    return file.path;
  }
  
  pw.Widget _contentHeader(pw.Context context, Uint8List bytelist, String title, String sheetCode, String date) {

    return pw.SizedBox(
      height: cellHeight * 3,
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Flexible(
            flex: 2,
            child: pw.Container(
              alignment: pw.Alignment.center,
              padding: const pw.EdgeInsets.all(10),
              decoration: const pw.BoxDecoration(
                border: pw.Border(
                  top: pw.BorderSide(width: 2),
                  left: pw.BorderSide(width: 2),
                  bottom: pw.BorderSide(width: 2),
                ),
              ),
              child: pw.Image(
                pw.MemoryImage(
                  bytelist,
                ),
                fit: pw.BoxFit.fitWidth,
              )
            ),
          ),
          pw.Flexible(
            flex: 3,
            child: pw.Container(
              alignment: pw.Alignment.center,
              decoration: const pw.BoxDecoration(
                border: pw.Border(
                  top: pw.BorderSide(width: 2),
                  left: pw.BorderSide(width: 2),
                  bottom: pw.BorderSide(width: 2),
                ),
              ),
              child: pw.Text(title, style: pw.TextStyle(fontSize: fontLargeSize, fontWeight: pw.FontWeight.bold)),
            ),
          ),
          pw.Flexible(
            flex: 1,
            child: pw.Container(
              alignment: pw.Alignment.center,
              decoration: const pw.BoxDecoration(
                border: pw.Border(
                  top: pw.BorderSide(width: 2),
                  left: pw.BorderSide(width: 2),
                  bottom: pw.BorderSide(width: 2),
                  right: pw.BorderSide(width: 2),
                ),
              ),
              child: pw.Column(
                children: [
                  pw.Expanded(
                    flex: 2,
                    child: pw.Container(
                      alignment: pw.Alignment.center,
                      child: pw.Text(sheetCode, style: pw.TextStyle(fontSize: fontMediumSize)),
                    )
                  ),
                  pw.Divider(thickness: 2),
                  pw.Expanded(
                    flex: 1,
                    child: pw.Text('DATA: $date', style: pw.TextStyle(fontSize: fontMediumSize)),
                  ),
                ]
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  pw.Widget _contentBasicInfo(pw.Context context) {
    return pw.SizedBox();
  }

  pw.Widget _contentServices(pw.Context context) {
    return pw.SizedBox();
  }

  pw.Widget _termsRegisters(pw.Context context) {
    return pw.SizedBox();
  }
}