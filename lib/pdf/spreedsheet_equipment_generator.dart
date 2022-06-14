import 'dart:io' as io;
import 'dart:io';
import 'package:formulario_de_atendimento/controllers/equipment_form/basic_info_equipment_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../default_values/default_values.dart';
import '../services/email_service.dart';

class SpreedsheetEquipmentGenerator {
  final String downloadsDirectory;
  SpreedsheetEquipmentGenerator({required this.downloadsDirectory}) {
    _loadImages();
  }

  final BasicInfoEquipmentController basicInfoEquipmentController = GetIt.I.get<BasicInfoEquipmentController>();

  late pw.Document pdf;

  io.File? file;

  late String fileName;

  createDocumentBase() {
    pdf = pw.Document();
  }

  Future<String> exportFile() async {
    final String name = fileName;
    try {
      final String filePath = '$downloadsDirectory/$name';
      final io.File file = io.File(filePath);
      await file.writeAsBytes(await pdf.save());

      return 'Salvo ${file.path}';
    } catch (e) {
      return 'Erro ao exportar: $e';
    }
    
  }

  Future<String> sendByEmail() async {

    if (file == null) return 'Arquivo não gerado'; 

    final message = await EmailService.sendEmail(
      subject: 'Formulário de Atendimento', 
      body: '', 
      file: file!,
    );

    return message;
  }

  void clear() {
    file = null;
  }

  bool get readToSendEmail => file != null;

  String _getName(scissors) {
    final String filePrefixName = scissors != null 
        ? scissors.replaceAll('TESOURA ', '').replaceAll(' ', '-') : 'tesoura';

    final String date = DateFormat('dd/MM/yyyy').format(DateTime.now()).replaceAll('/', '-');
    final String time = DateFormat('HH:mm:ss').format(DateTime.now()).replaceAll(':', '-');
    return '${filePrefixName.replaceAll('/', '-')}_${date}_$time.pdf';
  }

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
  
  Future<String> createSheet({
    String? scissors,
    String? spreedsheetDate,
    String? unit,
    String? os,
    String? localOfAttendance,
    bool isCorrective = true,
    bool isStoppedMachine = false,
    bool isTurnedKnife = false,
    bool isExcavator = true,
    bool isScissors = true,
    String? correctiveOrigin,
    String? fleet,
    String? model,
    String? odometer,

    String? defectCause,
    String? serviceCarried,
    String? motorOil,
    String? hydraulicOil,
    List<List<String>>? screws,
    List<List<String>>? shims,
    List<List<String>>? knives,
    String? pendencies,


    String? attedanceStartDate,
    String? attedanceEndDate,
    String? attedanceStartHour,
    String? attedanceEndHour,
    String? totalOfHours,
    List<String>? attendants,
  }) async {

    fileName = _getName(scissors);

    final String name = fileName;

    Directory tempDir = await getTemporaryDirectory();

    final String filePath = '${tempDir.path}/$name';

    try {
      pdf = pw.Document();
      pdf.addPage(
        pw.MultiPage(
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          mainAxisAlignment: pw.MainAxisAlignment.start,
          pageTheme: const pw.PageTheme(
            pageFormat: PdfPageFormat.a4,
            margin: pw.EdgeInsets.fromLTRB(24, 24, 24, 12),
          ),
          build: (context) => [
            _contentHeader(
              context: context,
              title: scissors ?? '',
              date: spreedsheetDate ?? '',
            ),
            _contentBasicInfo(
              context: context, 
              os: os ?? '',
              unit: unit ?? '',
              localOfAttendance: localOfAttendance ?? '',
              isStoppedMachine: isStoppedMachine,
              isTurnedKnife: isTurnedKnife,
              isCorrective: isCorrective,
              correctiveOrigin: correctiveOrigin,
              isExcavator: isExcavator,
              isScissors: isScissors,
              fleet: fleet ?? '',
              model: model ?? '',
              odometer: odometer ?? '',
              scissors: scissors ?? '',
            ),
            _contentServices(
              context: context,
              defectCause: defectCause ?? '',
              serviceCarried: serviceCarried ?? '',
              motorOil: motorOil ?? '',
              hydraulicOil: hydraulicOil ?? '',
              pendencies: pendencies ?? '',
              screws: screws ?? [],
              shims: shims ?? [], 
              knives: knives ?? [],
            ),
            _buildRegisters(
              context: context,
              attendants: attendants ?? [],
              attedanceStartDate: attedanceStartDate ?? '',
              attedanceEndDate: attedanceEndDate ?? '',
              attedanceStartHour: attedanceStartHour ?? '',
              attedanceEndHour: attedanceEndHour ?? '',
              totalOfHours: totalOfHours ?? '',
            ),
          ], 
        ),
      );

    file = io.File(filePath);
    await file!.writeAsBytes(await pdf.save());

    basicInfoEquipmentController.reset();
    if (localOfAttendance == LocalOfAttendance.piracicaba || localOfAttendance == LocalOfAttendance.iracenopolis) {
      await basicInfoEquipmentController.updateOs();
      basicInfoEquipmentController.generateOs();
      
    }

    return 'Salvo';



    } catch (e) {
      return 'Houve um erro: ${e.toString()}';
    }
  }

  pw.Widget _contentHeader({
    required pw.Context context, 
    required String title, 
    String date = '' }){
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
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(bottom: 4),
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
    String unit = '',
    String localOfAttendance = '',
    required bool isCorrective,
    required bool isStoppedMachine,
    required bool isTurnedKnife,
    String? correctiveOrigin,
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

    final String operationalFailure = correctiveOrigin == CorrectiveMaintenanceOriginEquipment.operationalFailure ? '[ X ] FALHA OPERACIONAL' : '[   ] FALHA OPERACIONAL';
    final String withoutPreventive = correctiveOrigin == CorrectiveMaintenanceOriginEquipment.withoutPreventive ? '[ X ] FALTA DE PREVENTIVA' : '[   ] FALTA DE PREVENTIVA';
    final String maintenanceFailure = correctiveOrigin == CorrectiveMaintenanceOriginEquipment.maintenanceFailure ? '[ X ] FALHA MANUTENÇÃO' : '[   ] FALHA MANUTENÇÃO';
    final String wearCommon = correctiveOrigin == CorrectiveMaintenanceOriginEquipment.wearCommon ? '[ X ] DESGASTE COMUM' : '[   ] DESGASTE COMUM';
    final String other = correctiveOrigin == CorrectiveMaintenanceOriginEquipment.other ? '[ X ] OUTROS' : '[   ] OUTROS';

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
                    pw.Text(localOfAttendance.toUpperCase(), style: pw.TextStyle(fontSize: fontMediumSize)),
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
               style: pw.TextStyle(fontSize: scissors.length <= 18 ? fontMediumSize : 7,
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

    motorOil.length < 9 ? fontSizeMotorOil = fontLargeSize * 2 : '';
    motorOil.length >= 9 && motorOil.length < 14 ? fontSizeMotorOil = fontLargeSize * 1.5 : '';
    motorOil.length > 14 ? fontSizeMotorOil = fontLargeMediumSize : '';

    hydraulicOil.length < 9 ? fontSizeHydraulicOil = fontLargeSize * 2 : '';
    hydraulicOil.length >= 9 && hydraulicOil.length < 14 ? fontSizeHydraulicOil = fontLargeSize * 1.5 : '';
    hydraulicOil.length > 14 ? fontSizeHydraulicOil = fontLargeMediumSize : '';

    final int tableLength = [screws, shims, knives].reduce((a, b) => a.length > b.length ? a : b).length;

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
          paddingBottom: cellHeight,
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
          paddingLeft: 0,
          child: pw.Row(
            children: [
              pw.SizedBox(
                width: 140,
                child: pw.Column(
                  children: [
                    _generateRow(
                      context: context,
                      height: cellHeight,
                    ),
                    _generateRow(
                      context: context,
                      height: cellHeight,
                    ),
                    _generateRow(
                      context: context,
                      height: cellHeight,
                    ),
                    _generateRow(
                      context: context,
                      height: cellHeight,
                    ),
                  ],
                ),
              ),
              pw.Expanded(
                child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.SizedBox(
                    width: 170,
                    child: pw.Column(
                      children: [
                        _generateRow(
                          context: context,
                          height: cellHeight,
                          borderTop: 1.5,
                          borderBottom: 1.5,
                          child: pw.Align(
                            alignment: pw.Alignment.center,
                            child: pw.Text('ÓLEO DE MOTOR UTILIZADO', style: pw.TextStyle(fontSize: fontMediumSize)),
                          )
                        ),
                        _generateRow(
                          context: context,
                          height: cellHeight * 3,
                          borderTop: 1.5,
                           child: pw.Row(
                            crossAxisAlignment: pw.CrossAxisAlignment.center,
                            mainAxisAlignment: pw.MainAxisAlignment.center,
                            children: [
                              pw.Expanded(
                                child: pw.Text(motorOil, style: pw.TextStyle(fontSize: fontSizeMotorOil, color: PdfColors.red) , textAlign: pw.TextAlign.center),
                              )
                            ]
                          )
                        ),
                      ]
                    )
                  ),
                  pw.Expanded(
                    child: pw.Column(
                      children: [
                        _generateRow(
                          context: context,
                          height: cellHeight,
                          paddingLeft: 0,
                        ),
                        _generateRow(
                          context: context,
                          height: cellHeight,
                          paddingLeft: 0,
                        ),
                        _generateRow(
                          context: context,
                          height: cellHeight,
                          paddingLeft: 0,
                        ),
                        _generateRow(
                          context: context,
                          height: cellHeight,
                          paddingLeft: 0,
                        ),
                      ],
                    ),
                  ),
                  pw.SizedBox(
                    width: 170,
                    child: pw.Column(
                      children: [
                        _generateRow(
                          context: context,
                          height: cellHeight,
                          borderTop: 1.5,
                          borderBottom: 1.5,
                          child: pw.Align(
                            alignment: pw.Alignment.center,
                            child: pw.Text('ÓLEO HIDRÁULICO UTILIZADO', style: pw.TextStyle(fontSize: fontMediumSize)),
                          )
                        ),
                        _generateRow(
                          context: context,
                          height: cellHeight * 3,
                          borderTop: 1.5,
                          child: pw.Row(
                            crossAxisAlignment: pw.CrossAxisAlignment.center,
                            mainAxisAlignment: pw.MainAxisAlignment.center,
                            children: [
                              pw.Expanded(
                                child: pw.Text(hydraulicOil, style: pw.TextStyle(fontSize: fontSizeHydraulicOil, color: PdfColors.red) , textAlign: pw.TextAlign.center),
                              )
                            ]
                          )
                        ),
                      ]
                    )
                  ),
                ]
                )
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
        _generateRow(
          context: context,
          height: cellHeight,
          borderTop: 1.5,
          paddingLeft: 1,
          child: pw.Row(
            children:[
              pw.Expanded(
                child: pw.Align(
                  alignment: pw.Alignment.center,
                  child: pw.Text('PARAFUSOS', style: pw.TextStyle(fontSize: fontLargeMediumSize, fontWeight: pw.FontWeight.bold)),
                )
              ),
              pw.VerticalDivider(thickness: 1, width: 1),
               pw.Expanded(
                child: pw.Align(
                  alignment: pw.Alignment.center,
                  child: pw.Text('CALÇOS', style: pw.TextStyle(fontSize: fontLargeMediumSize, fontWeight: pw.FontWeight.bold)),
                )
              ),
              pw.VerticalDivider(thickness: 1, width: 1),
              pw.Expanded(
                child: pw.Align(
                  alignment: pw.Alignment.center,
                  child: pw.Text('FACAS', style: pw.TextStyle(fontSize: fontLargeMediumSize, fontWeight: pw.FontWeight.bold)),
                )
              ),
            ]
          ),
        ),
        _generateRow(
          context: context,
          height: cellHeight,
          paddingLeft: 0,
          child: pw.Row(
            children:[
              pw.Expanded(
                child: pw.Row(
                  children: [
                    pw.Expanded(
                      child: _generateCell(
                        context: context,
                        content: 'CÓDIGO',
                      ),
                    ),
                    pw.Expanded(
                      child: _generateCell(
                        context: context,
                        content: 'TAMANHO',
                      )
                    ),
                    pw.SizedBox(
                      width: 40,
                      child: _generateCell(
                        context: context,
                        content: 'QUANTID.',
                      )
                    ),
                  ]
                )
              ),
              pw.Expanded(
                child: pw.Row(
                  children: [
                    pw.Expanded(
                      child: _generateCell(
                        context: context,
                        content: 'CÓDIGO',
                      )
                    ),
                    pw.Expanded(
                      child: _generateCell(
                        context: context,
                        content: 'TAMANHO',
                      )
                    ),
                    pw.SizedBox(
                      width: 40,
                      child: _generateCell(
                        context: context,
                        content: 'QUANTID.',
                      )
                    ),
                  ]
                )
              ),
              pw.Expanded(
                child: pw.Row(
                  children: [
                    pw.Expanded(
                      child: _generateCell(
                        context: context,
                        content: 'CÓDIGO',
                      )
                    ),
                    pw.Expanded(
                      child: _generateCell(
                        context: context,
                        content: 'FURAÇÃO',
                      )
                    ),
                    pw.SizedBox(
                      width: 40,
                      child: _generateCell(
                        context: context,
                        content: 'QUANTID.',
                      )
                    ),
                  ]
                )
              ),
            ]
          ),
        ),
        pw.ListView.builder(
          itemCount: tableLength,
          itemBuilder: (context, index) {
            return _generateRow(
              context: context,
              height: cellHeight,
              paddingLeft: 0,
              child: pw.Row(
                children: [
                  pw.Expanded(
                    child: pw.Row(
                      children: [
                        pw.Expanded(
                      child: _generateCell(
                        context: context,
                        content: screws.length - 1 >= index ? screws[index][0] : '',
                      )
                    ),
                    pw.Expanded(
                      child: _generateCell(
                        context: context,
                        content: screws.length - 1 >= index ? screws[index][1] : '',
                      )
                    ),
                    pw.SizedBox(
                      width: 40,
                      child: _generateCell(
                        context: context,
                        content: screws.length - 1 >= index ? screws[index][2] : '',
                      )
                    ),
                      ] 
                    )
                  ),
                  pw.Expanded(
                    child: pw.Row(
                      children: [
                        pw.Expanded(
                      child: _generateCell(
                        context: context,
                        content: shims.length - 1 >= index ? shims[index][0] : '',
                      )
                    ),
                    pw.Expanded(
                      child: _generateCell(
                        context: context,
                        content: shims.length - 1 >= index ? shims[index][1] : '',
                      )
                    ),
                    pw.SizedBox(
                      width: 40,
                      child: _generateCell(
                        context: context,
                        content: shims.length - 1 >= index ? shims[index][2] : '',
                      )
                    ),
                      ] 
                    )
                  ),
                  pw.Expanded(
                    child: pw.Row(
                      children: [
                        pw.Expanded(
                      child: _generateCell(
                        context: context,
                        content: knives.length - 1 >= index ? knives[index][0] : '',
                      )
                    ),
                    pw.Expanded(
                      child: _generateCell(
                        context: context,
                        content: knives.length - 1 >= index ? knives[index][1] : '',
                      )
                    ),
                    pw.SizedBox(
                      width: 40,
                      child: _generateCell(
                        context: context,
                        content: knives.length - 1 >= index ? knives[index][2] : '',
                      )
                    ),
                      ] 
                    )
                  ),
                ]
              )
            );
          }, 
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
              pw.Text('PENDÊNCIAS:', style: pw.TextStyle(fontSize: fontMediumSize, fontWeight: pw.FontWeight.bold)),
            ]
          ),
        ),
        _generateRow(
          context: context,
          paddingTop: 4,
          paddingRight: 4,
          paddingBottom: cellHeight,
          borderBottom: 1.5,
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Expanded(
                child: pw.Text(pendencies, style: pw.TextStyle(fontSize: fontMediumSize), textAlign: pw.TextAlign.center),
              ),
            ]
          ),
        ),
      ]
    );
  }




  pw.Widget _buildRegisters({
    required pw.Context context,
    required List<String> attendants,
    String attedanceStartDate = '',
    String attedanceEndDate = '',
    String attedanceStartHour = '',
    String attedanceEndHour = '',
    String totalOfHours = '',
  }) {

    attendants.insert(0, 'NOME');
    final listLength = attendants.length + 1;
    
    return pw.Column(
      children: [
        _generateRow(
          context: context,
          height: cellHeight * 3,
          paddingLeft: 0,
          child: pw.Row(
            children: [
              pw.SizedBox(
                width: 80,
                child: _generateRow(
                  context: context,
                  paddingLeft: 0,
                  borderBottom: 1.5,
                  borderTop: 1.5,
                  borderLeft: 1.5,
                  borderRight: 0,
                  color: PdfColors.grey300,
                   child: pw.Text(
                    'INÍCIO',
                    style: pw.TextStyle(fontSize: fontMediumSize, fontWeight: pw.FontWeight.bold),
                  )
                ),
              ),
              pw.Expanded(
                child: pw.Column(
                  children: [
                    _generateRow(
                      context: context,
                      height: cellHeight,
                      paddingLeft: 4,
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text(
                        'DATA: $attedanceStartDate',
                        style: pw.TextStyle(fontSize: fontSmallSize),
                      )
                    ),
                    _generateRow(
                      context: context,
                      height: cellHeight,
                      paddingLeft: 4,
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text(
                        'HORA: $attedanceStartHour',
                        style: pw.TextStyle(fontSize: fontSmallSize),
                      )
                    ),
                    _generateRow(
                      context: context,
                      height: cellHeight,
                      paddingLeft: 4,
                    ),
                  ]
                )
              ),
              pw.SizedBox(
                width: 80,
                child: _generateRow(
                  context: context,
                  paddingLeft: 0,
                  borderBottom: 1.5,
                  borderTop: 1.5,
                  borderLeft: 1.5,
                  borderRight: 0,
                  color: PdfColors.grey300,
                   child: pw.Text(
                    'FINAL',
                    style: pw.TextStyle(fontSize: fontMediumSize, fontWeight: pw.FontWeight.bold),
                  )
                ),
              ),
              pw.Expanded(
                child: pw.Column(
                  children: [
                    _generateRow(
                      context: context,
                      height: cellHeight,
                      paddingLeft: 4,
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text(
                        'DATA: $attedanceEndDate',
                        style: pw.TextStyle(fontSize: fontSmallSize),
                      )
                    ),
                    _generateRow(
                      context: context,
                      height: cellHeight,
                      paddingLeft: 4,
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text(
                        'HORA: $attedanceEndHour',
                        style: pw.TextStyle(fontSize: fontSmallSize),
                      )
                    ),
                    _generateRow(
                      context: context,
                      height: cellHeight,
                      paddingLeft: 4,
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text(
                        'TOTAL DE HORAS: $totalOfHours',
                        style: pw.TextStyle(fontSize: fontSmallSize),
                      )
                    ),
                  ]
                )
              ),
            ]
          )
        ),
        _generateRow(
          context: context,
          height: cellHeight * listLength,
          paddingLeft: 0,
          child: pw.Row(
            children: [
              pw.SizedBox(
                width: 80,
                child: _generateRow(
                  context: context,
                  paddingLeft: 0,
                  borderBottom: 1.5,
                  borderTop: 1.5,
                  borderLeft: 1.5,
                  borderRight: 0,
                  color: PdfColors.grey300,
                  child: pw.Text(
                    'ATENDIDO POR:',
                    style: pw.TextStyle(fontSize: fontMediumSize, fontWeight: pw.FontWeight.bold),
                  )
                ),
              ),
               pw.Expanded(
                child: pw.Column(
                  children: List.generate(listLength, (index) {
                    return _generateRow(
                      context: context,
                      height: cellHeight,
                      paddingLeft: 4,
                      child: pw.Text(
                        attendants.length - 1 >= index ? attendants[index] : '',
                        style: pw.TextStyle(fontSize: fontSmallSize),
                      )
                    );
                  })
                )
              ),
              pw.Expanded(
                child: pw.Column(
                  children: List.generate(listLength, (index) {
                    return _generateRow(
                      context: context,
                      height: cellHeight,
                      paddingLeft: 4,
                      child: pw.Text(
                        index == 0 ? 'ASSINATURA' : '',
                        style: pw.TextStyle(fontSize: fontSmallSize),
                      )
                    );
                  })
                )
              ),
            ]
          )
        ),
        _generateRow(
          context: context,
          height: cellSmallHeight * 4,
          borderTop: 1.5,
          paddingLeft: 0,
          child: pw.Row(
            children: [
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.Image(signature, alignment: pw.Alignment.bottomCenter, width: 70),
                    pw.Divider(thickness: 0.5, height: 8, indent: 40, endIndent: 40,),
                    pw.SizedBox(height: 4),
                    pw.Text('CHB - Responsável pelo atendimento', style: pw.TextStyle(fontSize: fontSmallSize)),
                  ]
                )
              ),
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.Image(signature, alignment: pw.Alignment.bottomCenter, width: 70),
                    pw.Divider(thickness: 0.5, height: 8, indent: 40, endIndent: 40,),
                    pw.SizedBox(height: 4),
                    pw.Text('Responsável - Cliente/Unidade', style: pw.TextStyle(fontSize: fontSmallSize)),
                  ]
                )
              ),
            ]
          )
        ),
        _generateRow(
          context: context,
          height: cellLargeHeight * 2,
          borderTop: 1.5,
          borderBottom: 1.5,
          paddingLeft: 0,
          paddingBottom: 4,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            mainAxisAlignment: pw.MainAxisAlignment.end,
            children: [
              pw.Text('CHB LOCAÇÕES, SERVIÇOS E COMÉRCIO LTDA.', 
              style: pw.TextStyle(
                fontSize: fontMediumSize, 
                fontWeight: pw.FontWeight.bold,)),
              pw.SizedBox(height: 4),
              pw.Text('R: Certa, N°163 - Bairro: Jardim Doraly - CEP: 07075-180 Tel.: (11) 2909-1757 locações@chbequipamentos - www.chbequipamentos.com.br',
              style: pw.TextStyle(
                fontSize: fontMediumSize,)),
            ]
          )
        )
      ]
    );
  }




  pw.Widget _generateRow({
    required pw.Context context, pw.Widget? child, double? height, PdfColor? color,
    double borderTop = 0, double borderLeft = 1.5, double borderRight = 1.5, double borderBottom = 1,
    double paddingLeft = 4, double paddingRight = 0, double paddingBottom = 0, double paddingTop = 0,
    pw.Alignment alignment = pw.Alignment.center,}) {
    return pw.Container(
      height: height,
      alignment: alignment,
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

  pw.Widget _generateCell({
    required pw.Context context,
    String content = '',
    double? fontSize,
    // bool isBorderLeft = false,
    // bool isBorderRight = false,
  }) {

    fontSize ??= content.length <= 13 ? fontMediumSize : fontSmallSize;

    return _generateRow(
      context: context,
      paddingLeft: 0,
      // borderLeft: isBorderLeft ? 0 : 1,
      // borderRight: isBorderRight ? 0 : 1,
      borderLeft: 1,
      borderRight: 1,
      borderTop: 0,
      borderBottom: 0,
      child: pw.Align(
        alignment: pw.Alignment.center,
        child: pw.Text(
          content, 
          style: pw.TextStyle(
            fontSize: fontSize,
            fontWeight: pw.FontWeight.bold
          ),
        textAlign: pw.TextAlign.center),
      ),
    );
  }
}