import 'package:excel/excel.dart';
import 'package:formulario_de_atendimento/default_values/default_values.dart';
import 'package:formulario_de_atendimento/models/client_form_settings/services_model.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../../rules/spreadsheet_generator.dart';

part 'services_controller.g.dart';

class ServicesController = ServicesControllerBase with _$ServicesController;

abstract class ServicesControllerBase with Store {

  final SpreadsheetGenerator spreadsheetGenerator = GetIt.I.get<SpreadsheetGenerator>(instanceName: 'client_form');
  
  @observable
  String oilWasUsed = YesNo.no;

  String? defect;
  String? cause;
  String? solution;
  String? motorOil;
  String? hydraulicOil = Situation.released;
  String? situation;
  String? pendencies;

  @observable
  bool isLoading = false;

  @action
  void setOilWasUsed(String value) {
    oilWasUsed = value;
    if (oilWasUsed != YesNo.yes) {
      motorOil = null;
      hydraulicOil = null;
    }
  }

  @action
  Future<String> addToSpreedsheet() async {
    isLoading = true;

    final ServicesModel services = ServicesModel();
    services.defect['value'] = defect;
    services.cause['value'] = cause;
    services.solution['value'] = solution;
    services.motorOil['value'] = motorOil;
    services.hydraulicOil['value'] = hydraulicOil;
    services.situation['value'] = situation;
    services.pendencies['value'] = pendencies;

    services.treatTheProperties();

    List<Map<String, String?>> servicesList = services.toList();
    for (Map<String, String?> element in servicesList) {
      if (element['value'] != null) {
        spreadsheetGenerator.updateCell(
          'CLIENTE',
          CellIndex.indexByString(element['cellAdress']!),
          element['value'],
        );
      }
    }
    
    String path = await spreadsheetGenerator.exportFile();

    isLoading = false;
    return path;
  }
}