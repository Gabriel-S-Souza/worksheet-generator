import 'dart:async';

import 'package:android_path_provider/android_path_provider.dart';
import 'package:flutter/services.dart';
import 'package:formulario_de_atendimento/models/client_form_models/basic_informations_model.dart';
import 'package:formulario_de_atendimento/models/client_form_models/registers_model.dart';
import 'package:formulario_de_atendimento/models/client_form_models/services_model.dart';
import 'package:formulario_de_atendimento/pdf/spreedsheet_client_genarator.dart';

class GeneralClientController {
  GeneralClientController() {
    _init();
  }
  late final SpreedsheetClientGenerator spreedsheetClientGenerator;

  late final String downloadDirectory;

  BasicInformationsModel? basicInformations;
  ServicesModel? services;
  RegistersModel? registers;

  get readyToSave =>
      basicInformations != null &&
      services != null &&
      registers != null;

  get readyToSendEmail => spreedsheetClientGenerator.readToSendEmail;

  Future<String> createSpreedsheet() async {
    if (basicInformations == null) {
      return 'A página de informações básicas não foi salva';
    } else if (services == null) {
      return 'A página de serviços não foi salva';
    } else if (registers == null) {
      return 'Esta página não foi salva';
    } 
    else {
      spreedsheetClientGenerator.createDocumentBase();
      String response = await spreedsheetClientGenerator.clientSheetCreate(
        spreedsheetDate: basicInformations!.spreedsheetDate,
        cliente: basicInformations!.client,
        os: basicInformations!.os,
        localOfAttendance: basicInformations!.localOfAttendance,
        isCorrective: basicInformations!.isCorrective,
        requester: basicInformations!.requester,
        attendant: basicInformations!.attendant,
        isStoppedMachine: basicInformations!.isStoppedMachine,
        isWarrenty: basicInformations!.isWarranty,
        equipment: basicInformations!.equipment!,
        application: basicInformations!.equipmentApplication!,
        correctiveOrigin: basicInformations!.correctiveMaintenanceOrigin!,
        fleet: basicInformations!.fleet,
        model: basicInformations!.model,
        series: basicInformations!.serie,
        odometer: basicInformations!.odometer,
        
        defect: services!.defect,
        cause: services!.cause,
        solution: services!.solution,
        motorOil: services!.motorOil,
        hydraulicOil: services!.hydraulicOil,
        situation: services!.situation,
        pendencies: services!.pendencies,

        attedanceDate: registers!.attendanceDate,
        attedanceStartHour: registers!.attendanceStartTime,
        attedanceEndHour: registers!.attendanceEndTime,
        totalOfHours: registers!.totalOfHours,      
      );

      basicInformations = null;
      services = null;
      registers = null;

      return response;
    }
  }

  void reset() {
    basicInformations = null;
    services = null;
    registers = null;
  }

  Future<void> _init() async {
    String? directory;

    try {
      directory = await AndroidPathProvider.downloadsPath;

      downloadDirectory = directory;

      spreedsheetClientGenerator = SpreedsheetClientGenerator(downloadDirectory);

    } on PlatformException {
      throw Exception('Could not get the downloads directory');
    }

  }

  String? checkIfCanCreate() {
    if (basicInformations == null) {
      return 'A página de informações básicas não foi salva';
    } else if (services == null) {
      return 'A página de serviços não foi salva';
    } else if (registers == null) {
      return 'Esta página não foi salva';
    } else {
      return null;
    }
  }

  Future<String> sendByEmail() async {
    return await spreedsheetClientGenerator.sendByEmail();
  }
  
  Future<String> export() async {
    return await spreedsheetClientGenerator.exportFile();
  }

  void clear() {
    spreedsheetClientGenerator.clear();
  }
}