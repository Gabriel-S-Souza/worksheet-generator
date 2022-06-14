import 'package:flutter/material.dart';
import 'package:formulario_de_atendimento/controllers/client_form/general_client_controller.dart';
import 'package:formulario_de_atendimento/models/client_form_models/registers_model.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

part 'registers_controller.g.dart';

class RegistersController = RegistersControllerBase with _$RegistersController;

abstract class RegistersControllerBase with Store {
  RegistersControllerBase() {
    autorun((_) {
      if (attendanceStartTimeOfDay != null && attendanceEndTimeOfDay != null) {
        int hourOfStartInMinutes = attendanceStartTimeOfDay!.hour * 60 + attendanceStartTimeOfDay!.minute;

        int hourOfEndInMinutes = attendanceEndTimeOfDay!.hour * 60 + attendanceEndTimeOfDay!.minute;

        if (hourOfEndInMinutes >= hourOfStartInMinutes) {
          int differenceInMinutes = hourOfEndInMinutes - hourOfStartInMinutes;

          TimeOfDay totalOfHoursTimeOfDay = TimeOfDay(
            hour: (differenceInMinutes / 60).floor(),
            minute: (differenceInMinutes % 60).floor(),
          );
          
          _setTotalOfHours(totalOfHoursTimeOfDay);
        } else {
          totalOfHours = '00:00';
        }
      }
    });
  }

  GeneralClientController generalClientController = GetIt.I.get<GeneralClientController>();
  
  @observable
  TimeOfDay? attendanceStartTimeOfDay;

  @observable
  TimeOfDay? attendanceEndTimeOfDay;
  
  TimeOfDay? totalOfHoursTimeOfDay;

  
  String? attendanceDate;
  String? attendanceStartTime;
  String? attendanceEndTime;

  @observable
  String? totalOfHours;

  @action
  void _setTotalOfHours(TimeOfDay? hours) {
    if (hours != null) {
      final String hoursFormated = hours.hour < 10 ? '0${hours.hour}' : '${hours.hour}';
      final String minutesFormated = hours.minute < 10 ? '0${hours.minute}' : '${hours.minute}';
      totalOfHours = '$hoursFormated:$minutesFormated';
    } else {
      totalOfHours = null;
    }
  }

  @observable
  bool isLoading = false;

  @observable
  bool loadOnExport = false;

  @observable
  bool loadOnSend = false;

  @computed
  bool get readyToSave => generalClientController.readyToSave;

  @computed
  bool get readyToSendEmail => generalClientController.readyToSendEmail;

  @action
  Future<String> save() async {
    isLoading = true;

    final RegistersModel registers = RegistersModel();

    registers.attendanceDate = attendanceDate;
    registers.attendanceStartTime = attendanceStartTime;
    registers.attendanceEndTime = attendanceEndTime;
    registers.totalOfHours = totalOfHours;

    await Future.delayed(const Duration(milliseconds: 500));


    generalClientController.registers = registers;

    String? response = await generalClientController.createSpreedsheet();
    
    isLoading = false;

    return response;
  }

  String? checkIfCanCreate() {
    return generalClientController.checkIfCanCreate();
  }
}