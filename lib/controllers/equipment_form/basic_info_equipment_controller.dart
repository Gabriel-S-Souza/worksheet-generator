import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobx/mobx.dart';

import '../../data/data_access_object.dart';
import '../../default_values/default_values.dart';
import '../../models/equipment_form_models/basic_informations.dart';
import 'general_equipment_controller.dart';

part 'basic_info_equipment_controller.g.dart';

class BasicInfoEquipmentController = BasicInfoEquipmentControllerBase with _$BasicInfoEquipmentController;

abstract class BasicInfoEquipmentControllerBase with Store {
  BasicInfoEquipmentControllerBase();
  
  GeneralEquipmentController generalEquipmentController = GetIt.I.get<GeneralEquipmentController>();
  final Box<dynamic> osBox = GetIt.I.get<Box<dynamic>>(instanceName: DefaultBoxes.os);
  
  

  @observable
  bool isAutoOS = true;

  @observable
  bool osWasGenerated = false;
  
  late String osGenerated;

  String? scissors;
  String? spreedsheetDate;
  String? unit;

  String? localOfAttendance = LocalOfAttendance.piracicaba;

  String? os;
  List<String> attendant = [];
  
  @observable
  bool isCorrective = true;

  String? isStoppedMachine = YesNo.no;
  String? isTurnedKnife = YesNo.no;

  @observable
  bool isExcavator = true;

  @observable
  bool isScissors = true;

  String correctiveMaintenanceOrigin = CorrectiveMaintenanceOrigin.wearCommon;
  String? fleet;
  String? model;
  String? odometer;

  @observable
  bool isLoading = false;

  @action
  Future<void> save() async {
    isLoading = true;

    final BasicInformationsModel basicInformations = BasicInformationsModel();
    basicInformations.scissors = scissors;
    basicInformations.spreedsheetDate = spreedsheetDate;
    basicInformations.os = isAutoOS ? osGenerated : os;
    basicInformations.unit = unit;
    basicInformations.localOfAttendance = localOfAttendance;
    basicInformations.isCorrective = isCorrective;
    basicInformations.isStoppedMachine = isStoppedMachine == YesNo.yes;
    basicInformations.isTurnedKnife = isTurnedKnife == YesNo.yes;
    basicInformations.isExcavator = isExcavator;
    basicInformations.isScissors = isScissors;
    basicInformations.correctiveOrigin = isCorrective ? correctiveMaintenanceOrigin : null;
    basicInformations.fleet = fleet;
    basicInformations.model = model;
    basicInformations.odometer = odometer;

    await Future.delayed(const Duration(milliseconds: 500));


    generalEquipmentController.basicInformations = basicInformations;
    
    isLoading = false;
  }

  @action
  void reset(){
    isAutoOS = true;
    osWasGenerated = false;
    scissors = null;
    spreedsheetDate = null;
    unit = null;
    localOfAttendance = LocalOfAttendance.piracicaba;
    os = null;
    isCorrective = true;
    isStoppedMachine = YesNo.no;
    isTurnedKnife = YesNo.no;
    isExcavator = true;
    isScissors = true;
    correctiveMaintenanceOrigin = CorrectiveMaintenanceOrigin.wearCommon;
    fleet = null;
    model = null;
    odometer = null;
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