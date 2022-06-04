import 'dart:io';

import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:formulario_de_atendimento/default_values/default_values.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class SpreadsheetPdfGenerator {
  final Directory downloadsDirectory;
  SpreadsheetPdfGenerator(this.downloadsDirectory);

  //TODO: GLOBAIS DE TESTE
  final String cliente = 'ARCELORMITAL PIRACICABA';
  final String os = '202201 - IRACE';
  final String localOfAttendance = 'PIRACICABA';
  final String correctiveValue = '[ X ] CORRETIVA';
  final String preventiveValue = '[   ] PREVENTIVA';
  final String requester = 'Alan';
  final String attendant = 'Jão da Silva';
  final String fleet = 'F-1234';


  final double cellLargeHeight = 22;
  final double cellHeight = 18;
  final double cellSmallHeight = 14;

  final double fontLargeSize = 16;
  final double fontLargeMediumSize = 12;
  final double fontMediumSize = 8;
  final double fontSmallSize = 6;

  late final ByteData logoBytes; 
  late final Uint8List logoByteList;

  late final ByteData arrowRedBytes; 
  late final Uint8List arrowRedByteList;

  late final ByteData arrowGreenBytes; 
  late final Uint8List arrowGreenByteList;

  late final pw.ImageProvider arrowLeft;
  late final pw.ImageProvider arrowRight;

  Future<void> _loadImages() async {
    logoBytes = await rootBundle.load('assets/images/logo.png');
    logoByteList = logoBytes.buffer.asUint8List();

    // arrowRedBytes = await rootBundle.load('assets/images/arrow-red.png');
    // arrowRedByteList = arrowRedBytes.buffer.asUint8List();

    // arrowGreenBytes = await rootBundle.load('assets/images/arrow-green.png');
    // arrowGreenByteList = arrowGreenBytes.buffer.asUint8List();
    
    return;
  }
  
  clientSheetCreate() async {
    const String name = 'teste.pdf';

    await _loadImages();
    arrowLeft = await imageFromAssetBundle('assets/images/arrow-red.png');
    arrowRight = await imageFromAssetBundle('assets/images/arrow-green.png');

    Directory tempDir = downloadsDirectory;
    String tempPath = tempDir.path;
    var filePath = '$tempPath/$name';

    final pdf = pw.Document();
    pdf.addPage(
      pw.MultiPage(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        mainAxisAlignment: pw.MainAxisAlignment.start,
        pageTheme: pw.PageTheme(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.symmetric(horizontal: 18, vertical: 22),
          theme: pw.ThemeData.withFont(
            base: await PdfGoogleFonts.robotoMedium(),
            bold: await PdfGoogleFonts.robotoBold(),
          ),
        ),
        build: (context) => [
          _contentHeader(context, logoByteList, 'RELATÓRIO DE ATENDIMENTO', 'XXXXX', '00/00/0000'),
          _contentBasicInfo(
            context: context, 
            client: cliente,
            os: os,
            localOfAttendance: localOfAttendance,
            correctiveValue: correctiveValue,
            preventiveValue: preventiveValue,
            requester: requester,
            attendant: attendant,
            fleet: fleet,
          ),
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
                  top: pw.BorderSide(width: 1.5),
                  left: pw.BorderSide(width: 1.5),
                  bottom: pw.BorderSide(width: 1.5),
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
                  top: pw.BorderSide(width: 1.5),
                  left: pw.BorderSide(width: 1.5),
                  bottom: pw.BorderSide(width: 1.5),
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
                  top: pw.BorderSide(width: 1.5),
                  left: pw.BorderSide(width: 1.5),
                  bottom: pw.BorderSide(width: 1.5),
                  right: pw.BorderSide(width: 1.5),
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
  
  
  pw.Widget _contentBasicInfo({
    required pw.Context context, required String client, required String os, 
    String localOfAttendance = '', required String correctiveValue, required String preventiveValue,
    String requester = '', String attendant = '', String yesStoppedMachine = '[   ] Sim',
    String noStoppedMachine = '[   ] Não', String yesWarrenty = '[   ] Sim', String noWarrenty = '[   ] Não',
    String equipment = '[   ] Carregadeira        [    ] Escavadeira        [   ] Rolo Compactador        [   ] Trator        [   ] Outros',
    String application = '[   ] Carregamento        [   ] Escavação        [   ] Terraplanagem        [   ] Rompedor        [   ] Sucata/Tesoura',
    String operationalFailure = '[   ] FALHA OPERACIONAL',
    String withoutPreventive = '[   ] FALTA DE PREVENTIVA',
    String wearByLoadedMaterial = '[   ] DESG. POR MATERIAL CARREGADO/ LOCAL DE OPERAÇÃO',
    String wearCommon = '[   ] DESGASTE COMUM',
    String other = '[   ] OUTROS',
    String fleet = '',
    String model = '',
    String series = '',
    String odometer = '',


    }) {
    return pw.Column(
      children: [
        _generateRow(
          context: context,
          height: cellLargeHeight,
          child: pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Expanded(
                flex: 3,
                child: pw.Row(
                  children: [
                    pw.SizedBox(
                      width: 100,
                      child: pw.Text('Cliente:', style: pw.TextStyle(fontSize: fontMediumSize)),
                    ),
                    pw.Text(client, style: pw.TextStyle(fontSize: fontMediumSize)),
                  ]
                )
              ),
              pw.VerticalDivider(thickness: 1, width: 1),
              pw.Expanded(
                flex: 2,
                child: pw.Row(
                  children: [
                    pw.Flexible(
                      flex: 1,
                      child: pw.Container(
                        height: cellHeight,
                        color: PdfColors.grey300,
                        alignment: pw.Alignment.center,
                        child: pw.Text('O.S:', style: pw.TextStyle(fontSize: fontMediumSize, fontWeight: pw.FontWeight.bold)),
                      )
                    ),
                    pw.Flexible(
                      flex: 3,
                        child: pw.Container(
                          alignment: pw.Alignment.center,
                          child: pw.Text(os, style: pw.TextStyle(fontSize: fontLargeMediumSize, color: PdfColors.red, fontWeight: pw.FontWeight.bold)),
                        )
                    )
                  ]
                )
              ),
            ]
          )
        ),
        _generateRow(
          context: context,
          height: cellLargeHeight,
          child: pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Expanded(
                flex: 3,
                child: pw.Row(
                  children: [
                    pw.SizedBox(
                      width: 100,
                      child: pw.Text('Local de Atendimento:', style: pw.TextStyle(fontSize: fontMediumSize)),
                    ),
                    pw.Text(localOfAttendance, style: pw.TextStyle(fontSize: fontMediumSize)),
                  ]
                )
              ),
              pw.VerticalDivider(thickness: 1, width: 1),
              pw.Expanded(
                flex: 2,
                child: pw.Padding(
                  padding: const pw.EdgeInsets.all(4),
                  child: pw.Row(
                    children: [
                      pw.Expanded(
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.center,
                          mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                          children: [
                            pw.Text(correctiveValue , style: pw.TextStyle(fontSize: fontSmallSize)),
                            pw.Image(arrowLeft, alignment: pw.Alignment.bottomCenter, width: 30),
                          ]
                        )
                      ),
                      pw.Expanded(
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.center,
                          mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                          children: [
                            pw.Text(preventiveValue, style: pw.TextStyle(fontSize: fontSmallSize)),
                            pw.Image(arrowRight, alignment: pw.Alignment.bottomCenter, width: 30),
                          ]
                        ),
                      )
                    ]
                  )
                )
              ),
            ]
          )
        ),
        _generateRow(
          context: context,
          height: cellHeight,
          child: pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Expanded(
                child: pw.Row(
                  children: [
                    pw.SizedBox(
                      width: 100,
                      child: pw.Text('Solicitado por:', style: pw.TextStyle(fontSize: fontMediumSize)),
                    ),
                    pw.Text(requester, style: pw.TextStyle(fontSize: fontMediumSize)),
                  ]
                )
              ),
              pw.VerticalDivider(thickness: 1, width: 1),
              pw.Expanded(
                child: pw.SizedBox(
                  width: 280,
                  child: pw.Row(
                    children: [
                      pw.Text('Ateendido por:  ', style: pw.TextStyle(fontSize: fontMediumSize)),
                      pw.Text(attendant, style: pw.TextStyle(fontSize: fontMediumSize)),
                    ]
                  )
                ),
              )
            ]
          ),
        ),
        _generateRow(
          context: context,
          height: cellHeight,
          child: pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Expanded(
                child: pw.Row(
                  children: [
                    pw.SizedBox(
                      width: 85,
                      child: pw.Text('Máquina parada:', style: pw.TextStyle(fontSize: fontMediumSize)),
                    ),
                    pw.SizedBox(width: 25),
                    pw.Text(yesStoppedMachine, style: pw.TextStyle(fontSize: fontMediumSize)),
                    pw.SizedBox(width: 35),
                    pw.Text(noStoppedMachine, style: pw.TextStyle(fontSize: fontMediumSize)),
                  ]
                )
              ),
              pw.VerticalDivider(thickness: 1, width: 1),
              pw.Expanded(
                child: pw.Row(
                  children: [
                    pw.SizedBox(
                      width: 50,
                      child: pw.Text('Garantia:', style: pw.TextStyle(fontSize: fontMediumSize)),
                    ),
                    pw.SizedBox(width: 25),
                    pw.Text(yesWarrenty, style: pw.TextStyle(fontSize: fontMediumSize)),
                    pw.SizedBox(width: 35),
                    pw.Text(noWarrenty, style: pw.TextStyle(fontSize: fontMediumSize)),
                  ]
                )
              ),
            ]
          ),
        ),
        _generateRow(
          context: context,
          height: cellSmallHeight * 1.8,
          borderBottom: 1.5,
          child: pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
            children: [
              pw.Row(
                children: [
                  pw.SizedBox(
                    width: 75,
                    child: pw.Text('Equipamento:', style: pw.TextStyle(fontSize: fontMediumSize)),
                  ),
                  pw.Text(equipment, style: pw.TextStyle(fontSize: fontMediumSize)),
                ]
              ),
              pw.Row(
                children: [
                  pw.SizedBox(
                    width: 75,
                    
                    child: pw.Text('Aplicação', style: pw.TextStyle(fontSize: fontMediumSize)),
                  ),
                  pw.Text(application, style: pw.TextStyle(fontSize: fontMediumSize)),
                ]
              ),
            ]
          ),
        ),
        _generateRow(
          context: context,
          height: cellHeight,
          borderBottom: 1.5,
          color: PdfColors.grey300,
          child: pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text('MANUTENÇÃO CORRETIVA ORIGINADA DE:', style: pw.TextStyle(fontSize: fontMediumSize, fontWeight: pw.FontWeight.bold)),
                ]
              ),
            ]
          ),
        ),
        _generateRow(
          context: context,
          height: cellLargeHeight,
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
             pw.Expanded(
               child: pw.Padding(padding: const pw.EdgeInsets.symmetric(horizontal: 4) ,child: pw.Text(operationalFailure, style: pw.TextStyle(fontSize: fontSmallSize), textAlign: pw.TextAlign.center),)
             ),
              pw.VerticalDivider(thickness: 1, width: 1),
             pw.Expanded(
               child: pw.Padding(padding: const pw.EdgeInsets.symmetric(horizontal: 4) ,child: pw.Text(withoutPreventive, style: pw.TextStyle(fontSize: fontSmallSize), textAlign: pw.TextAlign.center),)
             ),
              pw.VerticalDivider(thickness: 1, width: 1),
             pw.Expanded(
               child: pw.Padding(padding: const pw.EdgeInsets.symmetric(horizontal: 4) ,child: pw.Text(wearByLoadedMaterial, style: pw.TextStyle(fontSize: fontSmallSize), textAlign: pw.TextAlign.center),)
             ),
              pw.VerticalDivider(thickness: 1, width: 1),
             pw.Expanded(
               child: pw.Padding(padding: const pw.EdgeInsets.symmetric(horizontal: 4) ,child: pw.Text(wearCommon, style: pw.TextStyle(fontSize: fontSmallSize), textAlign: pw.TextAlign.center),)
             ),
              pw.VerticalDivider(thickness: 1, width: 1),
             pw.Expanded(
               child: pw.Padding(padding: const pw.EdgeInsets.symmetric(horizontal: 4) ,child: pw.Text(other, style: pw.TextStyle(fontSize: fontSmallSize), textAlign: pw.TextAlign.center),)
             ),
            ]
          ),
        ),
        _generateRow(
          context: context,
          height: cellHeight,
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
             pw.Expanded(
               child: pw.Text(
                 'FROTA: $fleet', 
                 style: pw.TextStyle(fontSize: fontMediumSize, 
                  color: fleet == '' ? null : PdfColors.red, fontWeight: pw.FontWeight.bold),),
             ),
              pw.VerticalDivider(thickness: 1, width: 1),
             pw.Expanded(
               child: pw.Padding(
                 padding: const pw.EdgeInsets.only(left: 4),
                 child: pw.Text(
                 'MODELO: $model', 
                 style: pw.TextStyle(fontSize: fontMediumSize, 
                  color: model == '' ? null : PdfColors.red, fontWeight: pw.FontWeight.bold),)
               )
               
             ),
              pw.VerticalDivider(thickness: 1, width: 1),
             pw.Expanded(
                child: pw.Padding(
                 padding: const pw.EdgeInsets.only(left: 4),
                 child: pw.Text(
                 'SÉRIE: $series', 
                 style: pw.TextStyle(fontSize: fontMediumSize,
                  color: series == '' ? null : PdfColors.red, fontWeight: pw.FontWeight.bold),)
                ) 
              ),
              pw.VerticalDivider(thickness: 1, width: 1),
             pw.Expanded(
               child: pw.Padding(
                 padding: const pw.EdgeInsets.only(left: 4),
                 child: pw.Text(
                 'HORÍMETRO: $odometer', 
               style: pw.TextStyle(fontSize: fontMediumSize,
                  color: odometer == '' ? null : PdfColors.red, fontWeight: pw.FontWeight.bold),)
                ),
              ),
            ]
          ),
        ),
      ]
    );
  }


  pw.Widget _contentServices(pw.Context context) {
    return pw.SizedBox();
  }

  pw.Widget _termsRegisters(pw.Context context) {
    return pw.SizedBox();
  }

  pw.Widget _generateRow({
    required pw.Context context, pw.Widget? child, double? height, PdfColor? color,
    double borderLeft = 1.5, double borderRight = 1.5, double borderBottom = 1}) {
    return pw.Container(
      height: height,
      alignment: pw.Alignment.center,
      padding: const pw.EdgeInsets.only(left: 4,),
      decoration: pw.BoxDecoration(
        color: color,
        border: pw.Border(
          left: pw.BorderSide(width: borderLeft),
          bottom: pw.BorderSide(width: borderBottom),
          right: pw.BorderSide(width: borderRight),
        ),
      ),
      child: child,
    );
  }
}