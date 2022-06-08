import 'dart:io' as io;
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class SpreadsheetEquipmentGenerator {
  final String downloadsDirectory;
  SpreadsheetEquipmentGenerator({required this.downloadsDirectory});

  //TODO: GLOBAIS DE TESTE
  final String unit = 'PIRACICABA';
  final String localOfAttendance = 'PIRACICABA';
  final String spreedsheetDate = '01/01/2020';
  final String os = '202201 - IRACE';
  final String fleet = 'F-1234';
  final String model = 'M-1234';
  final String odometer = 'C-1234';
  final scissors = 'TESOURA LABOUNTY MSD-4000';
  final bool isCorrective = true;
  final String operationalFailure = '[ X ] FALHA OPERACIONAL';
  final bool isStoppedMachine = false; 
  final bool isTurnedKnife = true; 

  final String defectCause = 'Defeito de teste';
  final String serviceCarried =
      ' Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum';
  final String motorOil = '300';
  final String hydraulicOil = '400400df';
  final String pendencies = ' laborum.';


  final List<List<String>> screws = [
    ['123456', '24X150', '10'],
    ['123456', '24X150', '10'],
    ['123456', '24X150', '10'],
    ['123456', '24X150', '10'],
    ['123456', '24X150', '10'],
    ['123456', '24X150', '10'],
  ];
  final List<List<String>> shims = [
    ['123456', '24X150', '10'],
    ['123456', '24X150', '10'],
    ['123456', '24X150', '10'],
    ['123456', '24X150', '10'],
    ['123456', '24X150', '10'],
    ['123456', '24X150', '10'],
    ['123456', '24X150', '10'],
    ['123456', '24X150', '10'],
    ['123456', '24X150', '10'],
  ];
  final List<List<String>> knives = [
    ['123456', '6 FUROS', '10'],
    ['123456', '6 FUROS', '10'],
    ['123456', '6 BICOS', '10'],
    ['123456', '6 BICOS', '10'],
    ['123456', 'LOSANGO', '10'],
    ['123456', 'LOSANGO', '10'],
  ];

  final String attedanceStartDate = '01/01/2020';
  final String attedanceEndDate = '01/01/2020';
  final String attedanceStartHour = '12:00';
  final String attedanceEndHour = '13:00';
  final String attendant = 'João da Silva';

  final String filePrefixName = 'labounty';

  final double cellLargeHeight = 20;
  final double cellHeight = 16;
  final double cellSmallHeight = 12;

  final double fontLargeSize = 16;
  final double fontLargeMediumSize = 12;
  final double fontMediumSize = 8;
  final double fontSmallSize = 6;

  late final pw.ImageProvider logo; 

  late final pw.ImageProvider arrowLeft;
  late final pw.ImageProvider arrowRight;

  late final pw.ImageProvider signature;

  Future<void> _loadImages() async {
    logo = await imageFromAssetBundle('assets/images/logo.png');
    arrowLeft = await imageFromAssetBundle('assets/images/arrow-red.png');
    arrowRight = await imageFromAssetBundle('assets/images/arrow-green.png');
    signature = await imageFromAssetBundle('assets/images/signature.png');
    
    return;
  }
  
  Future<String> createSheet() async {
    final String date = DateFormat('dd/MM/yyyy').format(DateTime.now()).replaceAll('/', '-');
    final String time = DateFormat('HH:mm:ss').format(DateTime.now()).replaceAll(':', '-');
    final String name = '${filePrefixName}_${date}_$time.pdf';

    final String filePath = '$downloadsDirectory/$name';

    await _loadImages();

    try {
      
      final pdf = pw.Document();
      pdf.addPage(
        pw.MultiPage(
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          mainAxisAlignment: pw.MainAxisAlignment.start,
          pageTheme: pw.PageTheme(
            pageFormat: PdfPageFormat.a4,
            margin: const pw.EdgeInsets.symmetric(horizontal: 32, vertical: 24),
            theme: pw.ThemeData.withFont(
              base: await PdfGoogleFonts.robotoMedium(),
              bold: await PdfGoogleFonts.robotoBold(),
            ),
          ),
          build: (context) => [
            _contentHeader(context, scissors, date: spreedsheetDate),
            _contentBasicInfo(
              context: context, 
              os: os,
              localOfAttendance: localOfAttendance,
              isCorrective: isCorrective,

              attendant: attendant,
              isExcavator: true,
              isScissors: true,
              fleet: fleet,
              model: model,
              odometer: odometer,
              scissors: scissors,
            ),
            _contentServices(
              context: context,
              defectCause: defectCause,
              serviceCarried: serviceCarried,
              motorOil: motorOil,
              hydraulicOil: hydraulicOil,
              pendencies: pendencies,
              screws: screws,
              shims: shims,
              knives: knives,
            ),
            _buildRegisters(),
          ], 
        ),
      );

    final io.File file = io.File(filePath);
    await file.writeAsBytes(await pdf.save());
    return file.path;



    } catch (e) {
      return 'Houve um erro: ${e.toString()}';
    }
  }

  pw.Widget _contentHeader(pw.Context context, String title, {String date = '' }){
    return pw.SizedBox(
      height: cellLargeHeight * 3,
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
                logo,
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
                      child: pw.SizedBox(),
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
    required pw.Context context,
    required String os,
    String localOfAttendance= '',
    bool isCorrective = true,
    bool isStoppedMachine = false,
    bool isTurnedKnife = false,
    String operationalFailure = '[   ] FALHA OPERACIONAL',
    String withoutPreventive = '[   ] FALTA DE PREVENTIVA',
    String maintenanceFailure = '[   ] FALHA MANUTENÇÃO',
    String wearCommon = '[   ] DESGASTE COMUM',
    String other = '[   ] OUTROS',
    String attendant  = '',
    bool isExcavator  = true,
    bool isScissors  = true,
    String fleet  = '',
    String model  = '',
    String odometer  = '',
    String scissors  = '',
  }){
    final String yesStoppedMachine;
    final String noStoppedMachine;
    final String yesTurnedKnife;
    final String noTurnedKnife;

    final String correctiveValue;
    final String preventiveValue;

    final String equipmentValue;
    final String applicationValue;

    if(isStoppedMachine) {
      yesStoppedMachine = '[ X ] Sim';
      noStoppedMachine = '[   ] Não';
    } else {
      yesStoppedMachine = '[   ] Sim';
      noStoppedMachine = '[ X ] Não';
    } 

    if(isTurnedKnife) {
      yesTurnedKnife = '[ X ] Sim';
      noTurnedKnife = '[   ] Não';
    } else {
      yesTurnedKnife = '[   ] Sim';
      noTurnedKnife = '[ X ] Não';
    }

    if(isCorrective) {
      correctiveValue = '[ X ] CORRETIVA';
      preventiveValue = '[   ] PREVENTIVA';
    } else {
      correctiveValue = '[   ] CORRETIVA';
      preventiveValue = '[ X ] PREVENTIVA';
    }

    if(isExcavator) {
      equipmentValue = '[ X ] Excavadeira';
    } else {
      equipmentValue = '[   ] Excavaderira';
    }

    if(isScissors) {
      applicationValue = '[ X ] Tesoura/Sucata';
    } else {
      applicationValue = '[   ] Tesoura/Sucata';
    }

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
                      child: pw.Text('UNIDADE:', style: pw.TextStyle(fontSize: fontMediumSize)),
                    ),
                    pw.Text(unit, style: pw.TextStyle(fontSize: fontMediumSize)),
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
          height: cellLargeHeight + 2,
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
                      width: 100,
                      child: pw.Text('VIRADA DE FACA:', style: pw.TextStyle(fontSize: fontMediumSize)),
                    ),
                    pw.SizedBox(width: 25),
                    pw.Text(yesTurnedKnife, style: pw.TextStyle(fontSize: fontMediumSize)),
                    pw.SizedBox(width: 35),
                    pw.Text(noTurnedKnife, style: pw.TextStyle(fontSize: fontMediumSize)),
                  ]
                )
              ),
            ]
          ),
        ),
        _generateRow(
          context: context,
          height: cellSmallHeight * 2,
          child: pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
            children: [
              pw.Row(
                children: [
                  pw.SizedBox(
                    width: 75,
                    child: pw.Text('Equipamento:', style: pw.TextStyle(fontSize: fontMediumSize)),
                  ),
                  pw.Text(equipmentValue, style: pw.TextStyle(fontSize: fontMediumSize)),
                ]
              ),
              pw.Row(
                children: [
                  pw.SizedBox(
                    width: 75,
                    
                    child: pw.Text('Aplicação', style: pw.TextStyle(fontSize: fontMediumSize)),
                  ),
                  pw.Text(applicationValue, style: pw.TextStyle(fontSize: fontMediumSize)),
                ]
              ),
            ]
          ),
        ),
        _generateRow(
          context: context,
          height: cellHeight,
          borderTop: 1.5,
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
               child: pw.Padding(padding: const pw.EdgeInsets.symmetric(horizontal: 4) ,child: pw.Text(maintenanceFailure, style: pw.TextStyle(fontSize: fontSmallSize), textAlign: pw.TextAlign.center),)
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
          borderBottom: 1.5,
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
             pw.Expanded(
               child: pw.Text(
                 'FROTA: $fleet', 
                 style: pw.TextStyle(fontSize: fleet.length <= 22 ? fontMediumSize : fontSmallSize, 
                  color: fleet == '' ? null : PdfColors.red, fontWeight: pw.FontWeight.bold),),
             ),
              pw.VerticalDivider(thickness: 1, width: 1),
             pw.Expanded(
               child: pw.Padding(
                 padding: const pw.EdgeInsets.only(left: 4),
                 child: pw.Text(
                 'MODELO: $model', 
                 style: pw.TextStyle(fontSize: model.length <= 18 ? fontMediumSize : fontSmallSize,
                  color: model == '' ? null : PdfColors.red, fontWeight: pw.FontWeight.bold),)
               )
               
             ),
              pw.VerticalDivider(thickness: 1, width: 1),
             pw.Expanded(
                child: pw.Padding(
                 padding: const pw.EdgeInsets.only(left: 4),
                 child: pw.Text(
                 'HORÍMETRO: $odometer', 
                 style: pw.TextStyle(fontSize: odometer.length <= 18 ? fontMediumSize : fontSmallSize,
                  color: odometer == '' ? null : PdfColors.red, fontWeight: pw.FontWeight.bold),)
                ) 
              ),
              pw.VerticalDivider(thickness: 1, width: 1),
             pw.Expanded(
               child: pw.Padding(
                 padding: const pw.EdgeInsets.only(left: 4),
                 child: pw.Text(
                 'TESOURA: ${scissors.replaceAll('TESOURA ', '')}', 
               style: pw.TextStyle(fontSize: scissors.length <= 18 ? fontMediumSize : fontSmallSize,
                  color: scissors == '' ? null : PdfColors.red, fontWeight: pw.FontWeight.bold),)
                ),
              ),
            ]
          ),
        ),
      ]
    );
  }


  pw.Widget _contentServices({
    required pw.Context context,
    String defectCause = '',
    String serviceCarried = '',
    String motorOil = '',
    String hydraulicOil = '',
    List<List<String>> screws = const [],
    List<List<String>> shims = const [],
    List<List<String>> knives = const [],
    String pendencies = '',
  }) {

    double fontSizeMotorOil = fontLargeSize;
    double fontSizeHydraulicOil = fontLargeSize;

    motorOil.length < 7 ? fontSizeMotorOil = fontLargeSize * 2 : '';
    motorOil.length > 7 && motorOil.length < 14 ? fontSizeMotorOil = fontLargeSize : '';
    motorOil.length > 14 ? fontSizeMotorOil = fontLargeMediumSize : '';

    hydraulicOil.length < 7 ? fontSizeHydraulicOil = fontLargeSize * 2 : '';
    hydraulicOil.length > 7 && hydraulicOil.length < 14 ? fontSizeHydraulicOil = fontLargeSize : '';
    hydraulicOil.length > 14 ? fontSizeHydraulicOil = fontLargeMediumSize : '';

    return pw.Column(
      children: [
         _generateRow(
          context: context,
          height: cellHeight,
          borderTop: 1.5,
          borderBottom: 1.5,
          color: PdfColors.grey300,
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Text('DEFEITO/CAUSA', style: pw.TextStyle(fontSize: fontMediumSize, fontWeight: pw.FontWeight.bold)),
            ]
          ),
        ),
        _generateRow(
          context: context,
          borderBottom: 1.5,
          paddingTop: 4,
          paddingBottom: cellHeight,
          paddingRight: 4,
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
               pw.Expanded(
                child: pw.Text(defectCause, style: pw.TextStyle(fontSize: fontMediumSize), textAlign: pw.TextAlign.center),
              ),
            ]
          ),
        ),
        _generateRow(
          context: context,
          height: cellHeight,
          borderTop: 1.5,
          borderBottom: 1.5,
          color: PdfColors.grey300,
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children:[
              pw.Text('SERVIÇO REALIZADO', style: pw.TextStyle(fontSize: fontMediumSize, fontWeight: pw.FontWeight.bold)),
            ]
          ),
        ),
        _generateRow(
          context: context,
          paddingTop: 4,
          paddingRight: 4,
          paddingBottom: serviceCarried.length < 300 ? cellHeight * 2 : cellHeight,
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Expanded(
                child: pw.Text(serviceCarried, style: pw.TextStyle(fontSize: fontMediumSize), textAlign: pw.TextAlign.center),
              ),
            ]
          ),
        ),
        _generateRow(
          context: context,
          height: cellHeight,
          borderTop: 1.5,
          borderBottom: 1.5,
          color: PdfColors.grey300,
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children:[
              pw.Text('MATERIAL UTILIZADO', style: pw.TextStyle(fontSize: fontMediumSize, fontWeight: pw.FontWeight.bold)),
            ]
          ),
        ),
      ]
    );
  }




  pw.Widget _buildRegisters() {
    return pw.SizedBox();
  }


  pw.Widget _generateRow({
    required pw.Context context, pw.Widget? child, double? height, PdfColor? color,
    double borderTop = 0, double borderLeft = 1.5, double borderRight = 1.5, double borderBottom = 1,
    double paddingLeft = 4, double paddingRight = 0, double paddingBottom = 0, double paddingTop = 0}) {
    return pw.Container(
      height: height,
      alignment: pw.Alignment.center,
      padding: pw.EdgeInsets.only(left: paddingLeft, bottom: paddingBottom, top: paddingTop, right: paddingRight),
      decoration: pw.BoxDecoration(
        color: color,
        border: pw.Border(
          top: pw.BorderSide(width: borderTop),
          left: pw.BorderSide(width: borderLeft),
          bottom: pw.BorderSide(width: borderBottom),
          right: pw.BorderSide(width: borderRight),
        ),
      ),
      child: child,
    );
  }
}