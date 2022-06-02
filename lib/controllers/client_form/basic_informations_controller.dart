import 'package:excel/excel.dart';
import 'package:formulario_de_atendimento/rules/spreadsheet_generator.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../../default_values/default_values.dart';
import '../../models/client_form_settings/basic_informations_model.dart';

part 'basic_informations_controller.g.dart';

class BasicInformaTionsController = BasicInformaTionsControllerBase with _$BasicInformaTionsController;

abstract class BasicInformaTionsControllerBase with Store {
  BasicInformaTionsControllerBase();
  
  final SpreadsheetGenerator spreadsheetGenerator = GetIt.I.get<SpreadsheetGenerator>(instanceName: 'client_form');

  String? date;
  String? client;
  String? localOfAttendance;
  String? os;
  String? requester;
  String? attendant;
  
  @observable
  String maintenance = Maintenance.corrective;

  String correctiveMaintenanceOrigin = CorrectiveMaintenanceOrigin.wearCommon;
  String isStoppedMachine = YesNo.no;
  String isWarranty = YesNo.no;
  String equipment = Equipment.loader;
  String equipmentApplication = EquipmentApplication.scrap;
  String? plate;
  String? fleet;
  String? model;
  String? serie;
  String? hourMeter;

  @observable
  bool isLoading = false;

  @action
  void addToSpreedsheet() {
    isLoading = true;

    final BasicInformationsModel basicInformations = BasicInformationsModel();
    basicInformations.date['value'] = date;
    basicInformations.client['value'] = client;
    basicInformations.localOfAttendance['value'] = localOfAttendance;
    basicInformations.os['value'] = os;
    basicInformations.requester['value'] = requester;
    basicInformations.attendant['value'] = attendant;
    basicInformations.maintenance['value'] = maintenance;
    basicInformations.correctiveMaintenanceOrigin['value'] = correctiveMaintenanceOrigin;
    basicInformations.isStoppedMachine['value'] = isStoppedMachine;
    basicInformations.isWarranty['value'] = isWarranty;
    basicInformations.equipment['value'] = equipment;
    basicInformations.equipmentApplication['value'] = equipmentApplication;
    basicInformations.plate['value'] = plate;
    basicInformations.fleet['value'] = fleet;
    basicInformations.model['value'] = model;
    basicInformations.serie['value'] = serie;
    basicInformations.hourMeter['value'] = hourMeter;

    basicInformations.treatTheProperties();

    List<Map<String, String?>> basicInformationsList = basicInformations.toList();
    for (Map<String, String?> element in basicInformationsList) {
      if (element['value'] != null) {
        spreadsheetGenerator.updateCell(
          'CLIENTE',
          CellIndex.indexByString(element['cellAdress']!),
          element['value'],
        );
      }
    }

    isLoading = false;
  }
}