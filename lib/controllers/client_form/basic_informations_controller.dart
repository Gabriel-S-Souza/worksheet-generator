import 'package:formulario_de_atendimento/controllers/client_form/general_client_controller.dart';
import 'package:formulario_de_atendimento/data/data_access_object.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobx/mobx.dart';

import '../../default_values/default_values.dart';
import '../../models/client_form_models/basic_informations_model.dart';

part 'basic_informations_controller.g.dart';

class BasicInformaTionsController = BasicInformaTionsControllerBase with _$BasicInformaTionsController;

abstract class BasicInformaTionsControllerBase with Store {
  BasicInformaTionsControllerBase();
  
  // SpreadsheetClientGenerator spreadsheetClientGenerator = SpreadsheetClientGenerator(widget.downloadsDirectory);
  GeneralClientController generalClientController = GetIt.I.get<GeneralClientController>();
  final Box<dynamic> osBox = GetIt.I.get<Box<dynamic>>(instanceName: DefaultBoxes.os);
  
  

  @observable
  bool isAutoOS = true;

  @observable
  bool osWasGenerated = false;
  
  late String osGenerated;

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
    basicInformations.os = isAutoOS ? osGenerated : os;
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


    generalClientController.basicInformations = basicInformations;
    
    isLoading = false;
  }

  @action
  void generateOs() {
    osWasGenerated = false;
    if (localOfAttendance != null) {
      final String osSufix;

    String year = DateTime.now().year.toString();

    final int osNumber;

    if (localOfAttendance == LocalOfAttendance.piracicaba) {
      osNumber = osBox.get(DefaultKeys.osPiracicaba);
      osSufix = osBox.get(DefaultKeys.piracicabaSufix);
    } else {
      osNumber = osBox.get(DefaultKeys.osIracemapolis);
      osSufix = osBox.get(DefaultKeys.iracemapolisSufix);
    }

    final String osNumberString  = osNumber < 10 ? '0$osNumber' : '$osNumber';
    osGenerated = '$year$osNumberString - $osSufix'; 
    osWasGenerated = true;     
    }
  }

  Future<void> updateOs() async {
    if (localOfAttendance == LocalOfAttendance.piracicaba) {
      osBox.put(DefaultKeys.osPiracicaba, osBox.get(DefaultKeys.osPiracicaba) + 1);
    } else if (localOfAttendance == LocalOfAttendance.iracenopolis) {
       osBox.put(DefaultKeys.osIracemapolis, osBox.get(DefaultKeys.osIracemapolis) + 1);
    }
    return;
  }
}