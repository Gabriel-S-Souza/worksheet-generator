import 'dart:io' as io;
import 'dart:io';

import 'package:formulario_de_atendimento/default_values/default_values.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../controllers/client_form/basic_informations_controller.dart';
import '../services/email_service.dart';

class SpreedsheetClientGenerator {
  final String downloadsDirectory;
  SpreedsheetClientGenerator(this.downloadsDirectory) {
    _loadImages();
  }

  final BasicInformaTionsController basicInformationsController = GetIt.I.get<BasicInformaTionsController>(instanceName: DefaultKeys.basicInfoControllerClient);
  
  late pw.Document pdf;

  io.File? file;

  late String fileName;

  void createDocumentBase() {
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

  Future<String> sendByEmail({String? body}) async {

    if (file == null) return 'Arquivo não gerado'; 

    final message = await EmailService.sendEmail(
      subject: 'Formulário de Atendimento', 
      body: body ?? '', 
      file: file!,
    );

    return message;
  }

  void clear() {
    file = null;
    createDocumentBase();
  }

  bool get readyToSendEmail => file != null;

  bool get readyToExport => pdf.document.pdfPageList.pages.isNotEmpty;

  String _getName() {
    final String date = DateFormat('dd/MM/yyyy').format(DateTime.now()).replaceAll('/', '-');
    final String time = DateFormat('HH:mm:ss').format(DateTime.now()).replaceAll(':', '-');
    return 'cliente_${date}_$time.pdf';
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
  
  Future<String> clientSheetCreate({
    String? spreedsheetDate,
    String? cliente,
    String? os,
    String? localOfAttendance,
    bool isCorrective = true,
    String? requester,
    String? attendant,
    bool isStoppedMachine = false,
    bool isWarrenty = false,
    String? equipment,
    String? application,
    required String correctiveOrigin,
    String? fleet,
    String? model,
    String? series,
    String? odometer,

    String? defect,
    String? cause,
    String? solution,
    String? motorOil,
    String? hydraulicOil,
    String? situation,
    String? pendencies,

    String? attedanceDate,
    String? attedanceStartHour,
    String? attedanceEndHour,
    String? totalOfHours,
  }) async {
    fileName = _getName();

    final String name = fileName; 

    final double extraSpace = cellLargeHeight;

    Directory tempDir = await getTemporaryDirectory();

    final String filePath = '${tempDir.path}/$name';

    try {
      
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
            _contentHeader(context, logo, 'RELATÓRIO DE ATENDIMENTO', spreedsheetDate ?? ''),
            _contentBasicInfo(
              context: context, 
              client: cliente ?? '',
              os: os ?? '',
              localOfAttendance: localOfAttendance ?? '', 
              isCorrective: isCorrective,
              correctiveOrigin: correctiveOrigin,
              isStoppedMachine: isStoppedMachine,
              isWarrenty: isWarrenty,
              requester: requester ?? '',
              attendant: attendant ?? '',
              equipment: equipment ?? '',
              application: application ?? '',
              fleet: fleet ?? '',
              series: series ?? '',
              model: model ?? '',
              odometer: odometer ?? '',
            ),
            _contentServices(
              context: context,
              defect: defect ?? '',
              cause: cause ?? '',
              solution: solution ?? '',
              motorOil: motorOil ?? '',
              hydraulicOil: hydraulicOil ?? '',
              situation: situation,
              pendencies: pendencies ?? '',
            ),
            _buildRegisters(
              context: context,
              attedanceDate: attedanceDate ?? '',
              attedanceStartHour: attedanceStartHour ?? '',
              attedanceEndHour: attedanceEndHour ?? '',
              totalOfHours: totalOfHours ?? '',
              extraSpace: extraSpace
            ),
          ], 
        ),
      );
      

      file = io.File(filePath);
      await file!.writeAsBytes(await pdf.save());

      basicInformationsController.reset();
      if (localOfAttendance == LocalOfAttendance.piracicaba || localOfAttendance == LocalOfAttendance.iracenopolis) {
        await basicInformationsController.updateOs();
        basicInformationsController.generateOs();
      }
      return 'Salvo';


    } catch (e) {
      return 'Houve um erro: ${e.toString()}';
    }
    
  }


   pw.Widget _contentHeader(pw.Context context, pw.ImageProvider bytelist, String title, String date) {

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
                    child: pw.Container()
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
    required String client, 
    required String os, 
    String localOfAttendance = '', 
    required bool isCorrective,
    required bool isStoppedMachine,
    required bool isWarrenty,
    String requester = '', 
    String attendant = '',
    String equipment = '[   ] Carregadeira        [    ] Escavadeira        [   ] Rolo Compactador        [   ] Trator        [   ] Outros',
    String application = '[   ] Carregamento        [   ] Escavação        [   ] Terraplanagem        [   ] Rompedor        [   ] Sucata/Tesoura',
    required String correctiveOrigin,
    String fleet = '',
    String model = '',
    String series = '',
    String odometer = '',
    }) {
    final String correctiveValue;
    final String preventiveValue;

    final String yesStoppedMachine;
    final String noStoppedMachine;

    final String yesWarrenty; 
    final String noWarrenty;

    final String operationalFailure = correctiveOrigin == CorrectiveMaintenanceOrigin.operationalFailure ? '[ X ] FALHA OPERACIONAL' : '[   ] FALHA OPERACIONAL';
    final String withoutPreventive = correctiveOrigin == CorrectiveMaintenanceOrigin.withoutPreventive ? '[ X ] FALTA DE PREVENTIVA' : '[   ] FALTA DE PREVENTIVA';
    final String wearByLoadedMaterial = correctiveOrigin == CorrectiveMaintenanceOrigin.wearByLoadedMaterial ? '[ X ] DESG. POR MATERIAL CARREGADO/ LOCAL DE OPERAÇÃO' : '[   ] DESG. POR MATERIAL CARREGADO/ LOCAL DE OPERAÇÃO';
    final String wearCommon = correctiveOrigin == CorrectiveMaintenanceOrigin.wearCommon ? '[ X ] DESGASTE COMUM' : '[   ] DESGASTE COMUM';
    final String other = correctiveOrigin == CorrectiveMaintenanceOrigin.other ? '[ X ] OUTROS' : '[   ] OUTROS';

    if(isStoppedMachine) {
      yesStoppedMachine = '[ X ] SIM';
      noStoppedMachine = '[   ] NÃO';
    } else {
      yesStoppedMachine = '[   ] SIM';
      noStoppedMachine = '[ X ] NÃO';
    }
    
    if(isWarrenty) {
      yesWarrenty = '[ X ] SIM';
      noWarrenty = '[   ] NÃO';
    } else {
      yesWarrenty = '[   ] SIM';
      noWarrenty = '[ X ] NÃO';
    }

    if(isCorrective) {
      correctiveValue = '[ X ] CORRETIVA';
      preventiveValue = '[   ] PREVENTIVA';
    } else {
      correctiveValue = '[   ] CORRETIVA';
      preventiveValue = '[ X ] PREVENTIVA';
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
          height: cellHeight + cellSmallHeight,
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
          borderBottom: 1.5,
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


  pw.Widget _contentServices({
    required pw.Context context,
    String defect = '',
    String cause = '',
    String solution = '',
    String motorOil = '',
    String hydraulicOil = '',
    String? situation,
    String pendencies = '',
  }) {

    situation ??= '[   ] LIBERADO          [   ] LIBERADO COM RESTRIÇÕES          [   ] NÃO LIBERADO           [   ] FALTA PEÇAS';

    double fontSizeMotorOil = fontLargeSize;
    double fontSizeHydraulicOil = fontLargeSize;

    motorOil.length < 9 ? fontSizeMotorOil = fontLargeSize * 2 : '';
    motorOil.length >= 9 && motorOil.length < 14 ? fontSizeMotorOil = fontLargeSize * 1.5 : '';
    motorOil.length > 14 ? fontSizeMotorOil = fontLargeMediumSize : '';

    hydraulicOil.length < 9 ? fontSizeHydraulicOil = fontLargeSize * 2 : '';
    hydraulicOil.length >= 9 && hydraulicOil.length < 14 ? fontSizeHydraulicOil = fontLargeSize * 1.5 : '';
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
              pw.Text('DEFEITO:', style: pw.TextStyle(fontSize: fontMediumSize, fontWeight: pw.FontWeight.bold)),
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
                child: pw.Text(defect, style: pw.TextStyle(fontSize: fontMediumSize), textAlign: pw.TextAlign.center),
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
              pw.Text('CAUSA:', style: pw.TextStyle(fontSize: fontMediumSize, fontWeight: pw.FontWeight.bold)),
            ]
          ),
        ),
        _generateRow(
          context: context,
          borderBottom: 1.5,
          paddingTop: 4,
          paddingRight: 4,
          paddingBottom: cellHeight,
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
               pw.Expanded(
                child: pw.Text(cause, style: pw.TextStyle(fontSize: fontMediumSize), textAlign: pw.TextAlign.center),
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
            children: [
              pw.Text('SOLUÇÃO:', style: pw.TextStyle(fontSize: fontMediumSize, fontWeight: pw.FontWeight.bold)),
            ]
          ),
        ),
        _generateRow(
          context: context,
          paddingTop: 4,
          paddingRight: 4,
          paddingBottom: solution.length < 240 ? cellHeight * 2 : cellHeight,
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Expanded(
                child: pw.Text(solution, style: pw.TextStyle(fontSize: fontMediumSize), textAlign: pw.TextAlign.center),
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
              )
            ]
          ),
        ),
        _generateRow(
          context: context,
          height: cellHeight,
          borderBottom: 1.5,
          child: pw.Row(
            children: [
              pw.Text('SITUAÇÃO:    ', style: pw.TextStyle(fontSize: fontMediumSize)),
              pw.Text(situation, style: pw.TextStyle(fontSize: fontMediumSize)),
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
              pw.Text('PENDÊNCIAS:', style: pw.TextStyle(fontSize: fontMediumSize, fontWeight: pw.FontWeight.bold)),
            ]
          ),
        ),
        _generateRow(
          context: context,
          paddingTop: 4,
          paddingRight: 4,
          paddingBottom: pendencies.length < 240 ? cellHeight * 2 : cellHeight,
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
    String attedanceDate = '',
    String attedanceStartHour = '',
    String attedanceEndHour = '',
    String totalOfHours = '',
    double extraSpace = 0,
  }) {

    return pw.Column(
      children: [
        _generateRow(
          context: context,
          height: cellHeight * 4,
          borderTop: 1.5,
          borderBottom: 1.5,
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
                    'ATENDIMENTO',
                    style: pw.TextStyle(fontSize: fontMediumSize, fontWeight: pw.FontWeight.bold),
                  )
                )
              ),
              pw.Expanded(
                child: pw.Column(
                  children: [
                    _generateRow(
                      context: context,
                      height: cellHeight,
                      borderLeft: 1,
                      borderRight: 1,
                      child: pw.Align(
                        alignment: pw.Alignment.center,
                        child: pw.Text('DATA', style: pw.TextStyle(fontSize: fontMediumSize)),
                      ) 
                    ),
                    _generateRow(
                      context: context,
                      height: cellHeight,
                      borderLeft: 1,
                      borderRight: 1,
                      child: pw.Align(
                        alignment: pw.Alignment.center,
                        child: pw.Text(attedanceDate, style: pw.TextStyle(fontSize: fontMediumSize)),
                      )
                    ),
                    _generateRow(
                      context: context,
                      height: cellHeight,
                      borderLeft: 1,
                      borderRight: 1,
                    ),
                    _generateRow(
                      context: context,
                      height: cellHeight,
                      borderLeft: 1,
                      borderRight: 1,
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
                      borderLeft: 1,
                      borderRight: 1,
                      child: pw.Align(
                        alignment: pw.Alignment.center,
                        child: pw.Text('HORA DE INÍCIO', style: pw.TextStyle(fontSize: fontMediumSize)),
                      ) 
                    ),
                    _generateRow(
                      context: context,
                      height: cellHeight,
                      borderLeft: 1,
                      borderRight: 1,
                      child: pw.Align(
                        alignment: pw.Alignment.center,
                        child: pw.Text(attedanceStartHour, style: pw.TextStyle(fontSize: fontMediumSize)),
                      )
                    ),
                    _generateRow(
                      context: context,
                      height: cellHeight,
                      borderLeft: 1,
                      borderRight: 1,
                    ),
                    _generateRow(
                      context: context,
                      height: cellHeight,
                      borderLeft: 1,
                      borderRight: 1,
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
                      borderLeft: 1,
                      borderRight: 1,
                      child: pw.Align(
                        alignment: pw.Alignment.center,
                        child: pw.Text('HORA DE TÉRMICO', style: pw.TextStyle(fontSize: fontMediumSize)),
                      ) 
                    ),
                    _generateRow(
                      context: context,
                      height: cellHeight,
                      borderLeft: 1,
                      borderRight: 1,
                      child: pw.Align(
                        alignment: pw.Alignment.center,
                        child: pw.Text(attedanceEndHour, style: pw.TextStyle(fontSize: fontMediumSize)),
                      )
                    ),
                    _generateRow(
                      context: context,
                      height: cellHeight,
                      borderLeft: 1,
                      borderRight: 1,
                    ),
                    _generateRow(
                      context: context,
                      height: cellHeight,
                      borderLeft: 1,
                      borderRight: 1,
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
                      borderLeft: 1,
                      borderRight: 1,
                      child: pw.Align(
                        alignment: pw.Alignment.center,
                        child: pw.Text('TOTAL DE HORAS', style: pw.TextStyle(fontSize: fontMediumSize)),
                      ) 
                    ),
                    _generateRow(
                      context: context,
                      height: cellHeight,
                      borderLeft: 1,
                      borderRight: 1,
                      child: pw.Align(
                        alignment: pw.Alignment.center,
                        child: pw.Text(totalOfHours, style: pw.TextStyle(fontSize: fontMediumSize)),
                      )
                    ),
                    _generateRow(
                      context: context,
                      height: cellHeight,
                      borderLeft: 1,
                      borderRight: 1,
                    ),
                    _generateRow(
                      context: context,
                      height: cellHeight,
                      borderLeft: 1,
                      borderRight: 1,
                    ),
                  ]
                )
              )
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
                    pw.Image(signature, alignment: pw.Alignment.bottomCenter, width: 75),
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
                    pw.Image(signature, alignment: pw.Alignment.bottomCenter, width: 75),
                    pw.Divider(thickness: 0.5, height: 8, indent: 40, endIndent: 40,),
                    pw.SizedBox(height: 4),
                    pw.Text('Autorização do Cliente', style: pw.TextStyle(fontSize: fontSmallSize)),
                  ]
                )
              ),
            ]
          )
        ),
        _generateRow(
          context: context,
          height: extraSpace,
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