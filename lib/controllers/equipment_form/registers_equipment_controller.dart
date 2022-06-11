import 'package:flutter/material.dart';
import 'package:formulario_de_atendimento/models/equipment_form_models/registers_model.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import 'general_equipment_controller.dart';

part 'registers_equipment_controller.g.dart';

class RegistersEquipmentController = RegistersEquipmentControllerBase with _$RegistersEquipmentController;

abstract class RegistersEquipmentControllerBase with Store {
  RegistersEquipmentControllerBase() {
    // autorun((_) {
    //   if (attendanceStartTimeOfDay != null && attendanceEndTimeOfDay != null) {
    //     int hourOfStartInMinutes = attendanceStartTimeOfDay!.hour * 60 + attendanceStartTimeOfDay!.minute;

    //     int hourOfEndInMinutes = attendanceEndTimeOfDay!.hour * 60 + attendanceEndTimeOfDay!.minute;

    //     if (hourOfEndInMinutes >= hourOfStartInMinutes) {
    //       int differenceInMinutes = hourOfEndInMinutes - hourOfStartInMinutes;

    //       TimeOfDay totalOfHoursTimeOfDay = TimeOfDay(
    //         hour: (differenceInMinutes / 60).floor(),
    //         minute: (differenceInMinutes % 60).floor(),
    //       );
          
    //       _setTotalOfHours(totalOfHoursTimeOfDay);
    //     } else {
    //       totalOfHours = '00:00';
    //     }
    //   }
    // });
  }

  GeneralEquipmentController generalEquipmentController = GetIt.I.get<GeneralEquipmentController>();
  
  @observable
  TimeOfDay? attendanceStartTimeOfDay;

  @observable
  TimeOfDay? attendanceEndTimeOfDay;
  
  TimeOfDay? totalOfHoursTimeOfDay;

  ObservableList<String> attendants = ObservableList<String>();

  
  String? attedanceStartDate;
  String? attedanceEndDate;
  String? attedanceStartHour;
  String? attedanceEndHour;

  @observable
  String? totalOfHours;

  // @action
  // void _setTotalOfHours(TimeOfDay? hours) {
  //   if (hours != null) {
  //     final String hoursFormated = hours.hour < 10 ? '0${hours.hour}' : '${hours.hour}';
  //     final String minutesFormated = hours.minute < 10 ? '0${hours.minute}' : '${hours.minute}';
  //     totalOfHours = '$hoursFormated:$minutesFormated';
  //   } else {
  //     totalOfHours = null;
  //   }
  // }

  @observable
  bool isLoading = false;

  @action
  Future<void> save() async {
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

    isLoading = false;
  }

  // String? checkIfCanCreate() {
  // }
}