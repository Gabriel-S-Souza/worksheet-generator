import 'dart:async';

import 'package:android_path_provider/android_path_provider.dart';
import 'package:flutter/services.dart';
import 'package:formulario_de_atendimento/models/equipment_form_models/registers_model.dart';
import 'package:formulario_de_atendimento/models/equipment_form_models/services_model.dart';

import '../../models/equipment_form_models/basic_informations.dart';
import '../../pdf/spreedsheet_equipment_generator.dart';

class GeneralEquipmentController {
  GeneralEquipmentController() {
    _init();
  }
  late final SpreedsheetEquipmentGenerator spreedsheetEquipmentGenerator;

  late final String downloadDirectory;

  BasicInformationsModel? basicInformations;
  ServicesModel? services;
  RegistersModel? registers;

  bool get readyToSave => spreedsheetEquipmentGenerator.readyToExport;

  bool get readyToSendEmail => spreedsheetEquipmentGenerator.readyToSendEmail;

  Future<String> createSpreedsheet() async {
    if (basicInformations == null) {
      return 'A página de informações básicas não foi salva';
    } 
    else if (services == null) {
      return 'A página de serviços não foi salva';
    } 
    else if (registers == null) {
      return 'Esta página não foi salva';
    } 
    else {
      spreedsheetEquipmentGenerator.createDocumentBase();
      String response = await spreedsheetEquipmentGenerator.createSheet(
        scissors: basicInformations!.scissors,
        spreedsheetDate: basicInformations!.spreedsheetDate,
        os: basicInformations!.os,
        unit: basicInformations!.unit,
        localOfAttendance: basicInformations!.localOfAttendance,
        isCorrective: basicInformations!.isCorrective,
        isStoppedMachine: basicInformations!.isStoppedMachine,
        isTurnedKnife: basicInformations!.isTurnedKnife,
        isExcavator: basicInformations!.isExcavator,
        isScissors: basicInformations!.isScissors,
        correctiveOrigin: basicInformations!.correctiveOrigin,
        fleet: basicInformations!.fleet,
        model: basicInformations!.model,
        odometer: basicInformations!.odometer,

        defectCause: services!.defectCause,
        serviceCarried: services!.serviceCarried,
        motorOil: services!.motorOil,
        hydraulicOil: services!.hydraulicOil,
        screws: services!.screws,
        shims: services!.shims,
        knives: services!.knives,
        pendencies: services!.pendencies,

        attendants: registers!.attendants,
        attedanceStartDate: registers!.attedanceStartDate,
        attedanceEndDate: registers!.attedanceEndDate,
        attedanceStartHour: registers!.attedanceStartHour,
        attedanceEndHour: registers!.attedanceEndHour,
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

    spreedsheetEquipmentGenerator.clear();
  }

  Future<void> _init() async {
    String? directory;

    try {
      directory = await AndroidPathProvider.downloadsPath;

      downloadDirectory = directory;

      spreedsheetEquipmentGenerator = SpreedsheetEquipmentGenerator(downloadsDirectory: downloadDirectory);

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

  Future<String> export() async {
    return await spreedsheetEquipmentGenerator.exportFile();
  }

  Future<String> sendByEmail() async {
    return await spreedsheetEquipmentGenerator.sendByEmail();
  }

  void clear() {
    spreedsheetEquipmentGenerator.clear();
  }
}