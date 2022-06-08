import 'dart:developer';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:formulario_de_atendimento/pdf/spreadsheet_xlsx_generator.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../../models/client_form_settings/registers_model.dart';

part 'registers_controller.g.dart';

class RegistersController = RegistersControllerBase with _$RegistersController;

abstract class RegistersControllerBase with Store {

  final SpreadsheetXlsxGenerator spreadsheetXlsxGenerator = GetIt.I.get<SpreadsheetXlsxGenerator>(instanceName: 'client_form');

  TimeOfDay? departureHour;
  TimeOfDay? departureBackHour;
  TimeOfDay? arrivalHour;
  TimeOfDay? arrivalBackHour;
  TimeOfDay? attendanceStartHour;
  TimeOfDay? attendanceEndHour;

  String? oneWayDepartureDate;
  String? oneWayDepartureTime;

  String? oneWayArrivalDate;
  String? oneWayArrivalTime;

  String? returnDepartureDate;
  String? returnDepartureTime;

  String? returnArrivalDate;
  String? returnArrivalTime;

  String? initialKm;
  String? finalKm;

  String? attendanceDate;
  String? attendanceStartTime;
  String? attendanceEndTime;

  @observable
  bool isLoading = false;

  @action
  Future<String> addToSpreedsheet() async {
    isLoading = true;

    final RegistersModel registers = RegistersModel();
    registers.oneWayDepartureDate = oneWayDepartureDate;
    registers.oneWayDepartureTime = oneWayDepartureTime;
    registers.oneWayArrivalDate = oneWayArrivalDate;
    registers.oneWayArrivalTime = oneWayArrivalTime;
    registers.returnDepartureDate = returnDepartureDate;
    registers.returnDepartureTime = returnDepartureTime;
    registers.returnArrivalDate = returnArrivalDate;
    registers.returnArrivalTime = returnArrivalTime;
    registers.initialKm = initialKm;
    registers.finalKm = finalKm;
    registers.attendanceDate = attendanceDate;
    registers.attendanceStartTime = attendanceStartTime;
    registers.attendanceEndTime = attendanceEndTime;

    registers.treatTheProperties();

    // registers.toList().forEach((element) {
    //   print(element);
    // });
    
    List<Map<String, String?>> registersList = registers.toList();
    for (Map<String, String?> element in registersList) {
      if (element['value'] != null) {
        spreadsheetXlsxGenerator.updateCell(
          'CLIENTE',
          CellIndex.indexByString(element['cellAdress']!),
          element['value'],
        );
      }
    }

    String path = await spreadsheetXlsxGenerator.exportFile();

    isLoading = false;
    return path;
  }
}