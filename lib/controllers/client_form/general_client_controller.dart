import 'package:android_path_provider/android_path_provider.dart';
import 'package:flutter/services.dart';
import 'package:formulario_de_atendimento/models/client_form_settings/basic_informations_model.dart';
import 'package:formulario_de_atendimento/models/client_form_settings/registers_model.dart';
import 'package:formulario_de_atendimento/models/client_form_settings/services_model.dart';
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

  Future<String> createSpreedsheet() async {
    if (basicInformations == null) {
      return 'A página de informações básicas não foi salva';
    }
    //  else if (services == null) {
    //   return 'A página de serviços não foi salva';
    // } else if (registers == null) {
    //   return 'A página de atendimento não foi salva';
    // } 
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
      
      );

      basicInformations = null;
      services = null;
      registers = null;

      return response;
    }
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
}