import 'package:formulario_de_atendimento/controllers/client_form/general_client_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../../default_values/default_values.dart';
import '../../models/client_form_settings/basic_informations_model.dart';

part 'basic_informations_controller.g.dart';

class BasicInformaTionsController = BasicInformaTionsControllerBase with _$BasicInformaTionsController;

abstract class BasicInformaTionsControllerBase with Store {
  BasicInformaTionsControllerBase();
  
  // SpreadsheetClientGenerator spreadsheetClientGenerator = SpreadsheetClientGenerator(widget.downloadsDirectory);
  GeneralClientController clientController = GetIt.I.get<GeneralClientController>();

  @observable
  bool isAutoOS = true;

  String? spreedsheetDate;
  String? client;

  String? localOfAttendance = LocalOfAttendance.piracicaba;

  String? os;
  String? requester;
  String? attendant;
  
  @observable
  bool isCorrective = true;

  String correctiveMaintenanceOrigin = CorrectiveMaintenanceOrigin.wearCommon;
  String isStoppedMachine = YesNo.no;
  String isWarranty = YesNo.no;
  String equipment = Equipment.excavator;
  String equipmentApplication = EquipmentApplication.scrap;
  String? plate;
  String? fleet;
  String? model;
  String? serie;
  String? odometer;

  @observable
  bool isLoading = false;

  @action
  Future<void> save() async {
    isLoading = true;

    final BasicInformationsModel basicInformations = BasicInformationsModel();
    basicInformations.spreedsheetDate = spreedsheetDate;
    basicInformations.client = client;
    basicInformations.localOfAttendance = localOfAttendance;
    basicInformations.os = os;
    basicInformations.requester = requester;
    basicInformations.attendant = attendant;
    basicInformations.isCorrective = isCorrective;
    basicInformations.correctiveMaintenanceOrigin = correctiveMaintenanceOrigin;
    basicInformations.isStoppedMachine = isStoppedMachine == YesNo.yes;
    basicInformations.isWarranty = isWarranty == YesNo.yes;
    basicInformations.equipment = equipment;
    basicInformations.equipmentApplication = equipmentApplication;
    basicInformations.fleet = fleet;
    basicInformations.model = model;
    basicInformations.serie = serie;
    basicInformations.odometer = odometer;
    
    basicInformations.treatTheProperties();

    await Future.delayed(const Duration(milliseconds: 500));


    clientController.basicInformations = basicInformations;
    
    isLoading = false;
  }
}