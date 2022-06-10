import 'package:formulario_de_atendimento/models/equipment_form_models/services_model.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../../default_values/default_values.dart';
import 'general_equipment_controller.dart';

part 'services_equipment_controller.g.dart';

class ServicesEquipmentController = ServicesEquipmentControllerBase with _$ServicesEquipmentController;

abstract class ServicesEquipmentControllerBase with Store {

  GeneralEquipmentController generalEquipmentController = GetIt.I.get<GeneralEquipmentController>();
  
  @observable
  String oilWasUsed = YesNo.no;

  String? defectCause;
  String? serviceCarried;
  String? motorOil;
  String? hydraulicOil;

  ObservableList<List<String>> screws = ObservableList<List<String>>();

  ObservableList<List<String>> shims = ObservableList<List<String>>();

  ObservableList<List<String>> knives = ObservableList<List<String>>();

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
  Future<void> save() async {
    isLoading = true;

    final ServicesModel services = ServicesModel();
    services.defectCause = defectCause;
    services.serviceCarried = serviceCarried;
    services.motorOil = motorOil;
    services.hydraulicOil = hydraulicOil;
    services.screws = screws;
    services.shims = shims;
    services.knives = knives;
    services.pendencies = pendencies;    

    await Future.delayed(const Duration(milliseconds: 500));


    generalEquipmentController.services = services;
    
    isLoading = false;
  }
}