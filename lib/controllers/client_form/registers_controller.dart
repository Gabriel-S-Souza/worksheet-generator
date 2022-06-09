import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'registers_controller.g.dart';

class RegistersController = RegistersControllerBase with _$RegistersController;

abstract class RegistersControllerBase with Store {

  // final SpreadsheetXlsxGenerator spreadsheetXlsxGenerator = GetIt.I.get<SpreadsheetXlsxGenerator>(instanceName: 'client_form');

  TimeOfDay? attendanceStartHour;
  TimeOfDay? attendanceEndHour;

  String? attendanceDate;
  String? attendanceStartTime;
  String? attendanceEndTime;

  @observable
  bool isLoading = false;

  // @action
  // Future<String> addToSpreedsheet() async {
  //   isLoading = true;

  //   final RegistersModel registers = RegistersModel();
  //   registers.attendanceDate = attendanceDate;
  //   registers.attendanceStartTime = attendanceStartTime;
  //   registers.attendanceEndTime = attendanceEndTime;

  //   registers.treatTheProperties();
    
  //   List<Map<String, String?>> registersList = registers.toList();
  //   for (Map<String, String?> element in registersList) {
  //     if (element['value'] != null) {
  //       spreadsheetXlsxGenerator.updateCell(
  //         'CLIENTE',
  //         CellIndex.indexByString(element['cellAdress']!),
  //         element['value'],
  //       );
  //     }
  //   }

  //   String path = await spreadsheetXlsxGenerator.exportFile();

  //   isLoading = false;
  //   return path;
  // }
}