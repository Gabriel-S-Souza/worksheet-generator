import 'package:flutter/material.dart';
import 'package:formulario_de_atendimento/models/equipment_form_models/registers_model.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import 'general_equipment_controller.dart';

part 'registers_equipment_controller.g.dart';

class RegistersEquipmentController = RegistersEquipmentControllerBase with _$RegistersEquipmentController;

abstract class RegistersEquipmentControllerBase with Store {

  GeneralEquipmentController generalEquipmentController = GetIt.I.get<GeneralEquipmentController>();
  
  @observable
  TimeOfDay? attendanceStartTimeOfDay;

  @action
  void setAttendanceStartTimeOfDay(TimeOfDay value) => attendanceStartTimeOfDay = value;

  @observable
  TimeOfDay? attendanceEndTimeOfDay;

  @action
  void setAttendanceEndTimeOfDay(TimeOfDay value) => attendanceEndTimeOfDay = value;
  
  TimeOfDay? totalOfHoursTimeOfDay;

  ObservableList<String> attendants = ObservableList<String>();

  
  String? attedanceStartDate;
  String? attedanceEndDate;
  String? attedanceStartHour;
  String? attedanceEndHour;

  @observable
  String? totalOfHours;

  @observable
  bool isTotalOfHoursEditable = false;

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

  @action
  void calculateHoursDifference() {
    if (attendanceStartTimeOfDay != null && attendanceEndTimeOfDay != null
      && attedanceStartDate != null && attedanceEndDate != null) {
      
      String hoursStartFormated = attendanceStartTimeOfDay!.hour < 10 ? '0${attendanceStartTimeOfDay!.hour}' : '${attendanceStartTimeOfDay!.hour}';
      String minutesStartFormated = attendanceStartTimeOfDay!.minute < 10 ? '0${attendanceStartTimeOfDay!.minute}' : '${attendanceStartTimeOfDay!.minute}';
      String hoursEndFormated = attendanceEndTimeOfDay!.hour < 10 ? '0${attendanceEndTimeOfDay!.hour}' : '${attendanceEndTimeOfDay!.hour}';
      String minutesEndFormated = attendanceEndTimeOfDay!.minute < 10 ? '0${attendanceEndTimeOfDay!.minute}' : '${attendanceEndTimeOfDay!.minute}';

      DateTime startDate = DateTime.parse(
        '${attedanceStartDate!.substring(6)}-${attedanceStartDate!.substring(3, 5)}-${attedanceStartDate!.substring(0, 2)} $hoursStartFormated:$minutesStartFormated:00');
      DateTime endDate = DateTime.parse(
        '${attedanceEndDate!.substring(6)}-${attedanceEndDate!.substring(3, 5)}-${attedanceEndDate!.substring(0, 2)} $hoursEndFormated:$minutesEndFormated:00');

      var differenceMinutes = endDate.difference(startDate).inMinutes;

      if (differenceMinutes >= 0) {
        TimeOfDay totalOfHoursTimeOfDay = TimeOfDay(
        hour: (differenceMinutes / 60).floor(),
        minute: (differenceMinutes % 60).floor(),
      );
        
      _setTotalOfHours(totalOfHoursTimeOfDay);

      } else {
        totalOfHours = '00:00';
      }
       
       } else {
        totalOfHours = '00:00';
      }
  }

  @observable
  bool readyToSave = false;

  @observable
  bool readyToSendEmail = false;

  @action
  void setReadyToSave() => readyToSave = generalEquipmentController.readyToSave;

  @action
  void setReadyToSendEmail() => readyToSendEmail = generalEquipmentController.readyToSendEmail;
  
  @observable
  bool isLoading = false;

  @observable
  bool loadOnExport = false;

  @observable
  bool loadOnSend = false;

  @action
  Future<String> save() async {
    isLoading = true;

    final RegistersModel registers = RegistersModel();

    registers.attedanceStartDate = attedanceStartDate;
    registers.attedanceEndDate = attedanceEndDate;
    registers.attedanceStartHour = attedanceStartHour;
    registers.attedanceEndHour = attedanceEndHour;
    registers.totalOfHours = totalOfHours;
    registers.attendants = attendants;

    await Future.delayed(const Duration(milliseconds: 500));

    generalEquipmentController.registers = registers;

    String message = await generalEquipmentController.createSpreedsheet();

    isLoading = false;

    setReadyToSave();
    setReadyToSendEmail();

    return message;
  }

  String? checkIfCanCreate() {
    return generalEquipmentController.checkIfCanCreate();
  }
}