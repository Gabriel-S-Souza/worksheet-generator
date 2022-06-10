import 'package:formulario_de_atendimento/controllers/client_form/general_client_controller.dart';
import 'package:formulario_de_atendimento/default_values/default_values.dart';
import 'package:formulario_de_atendimento/models/client_form_models/services_model.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

part 'services_controller.g.dart';

class ServicesController = ServicesControllerBase with _$ServicesController;

abstract class ServicesControllerBase with Store {

  GeneralClientController generalClientController = GetIt.I.get<GeneralClientController>();
  
  @observable
  String oilWasUsed = YesNo.no;

  String? defect;
  String? cause;
  String? solution;
  String? motorOil;
  String? hydraulicOil;
  String? situation = Situation.released;
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

    services.defect = defect;
    services.cause = cause;
    services.solution = solution;
    services.motorOil = motorOil;
    services.hydraulicOil = hydraulicOil;
    services.situation = situation;
    services.pendencies = pendencies;
    
    services.treatTheProperties();

    await Future.delayed(const Duration(milliseconds: 500));


    generalClientController.services = services;
    
    isLoading = false;
  }
}