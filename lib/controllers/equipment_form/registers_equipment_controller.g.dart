// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registers_equipment_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RegistersEquipmentController
    on RegistersEquipmentControllerBase, Store {
  late final _$attendanceStartTimeOfDayAtom = Atom(
      name: 'RegistersEquipmentControllerBase.attendanceStartTimeOfDay',
      context: context);

  @override
  TimeOfDay? get attendanceStartTimeOfDay {
    _$attendanceStartTimeOfDayAtom.reportRead();
    return super.attendanceStartTimeOfDay;
  }

  @override
  set attendanceStartTimeOfDay(TimeOfDay? value) {
    _$attendanceStartTimeOfDayAtom
        .reportWrite(value, super.attendanceStartTimeOfDay, () {
      super.attendanceStartTimeOfDay = value;
    });
  }

  late final _$attendanceEndTimeOfDayAtom = Atom(
      name: 'RegistersEquipmentControllerBase.attendanceEndTimeOfDay',
      context: context);

  @override
  TimeOfDay? get attendanceEndTimeOfDay {
    _$attendanceEndTimeOfDayAtom.reportRead();
    return super.attendanceEndTimeOfDay;
  }

  @override
  set attendanceEndTimeOfDay(TimeOfDay? value) {
    _$attendanceEndTimeOfDayAtom
        .reportWrite(value, super.attendanceEndTimeOfDay, () {
      super.attendanceEndTimeOfDay = value;
    });
  }

  late final _$totalOfHoursAtom = Atom(
      name: 'RegistersEquipmentControllerBase.totalOfHours', context: context);

  @override
  String? get totalOfHours {
    _$totalOfHoursAtom.reportRead();
    return super.totalOfHours;
  }

  @override
  set totalOfHours(String? value) {
    _$totalOfHoursAtom.reportWrite(value, super.totalOfHours, () {
      super.totalOfHours = value;
    });
  }

  late final _$isTotalOfHoursEditableAtom = Atom(
      name: 'RegistersEquipmentControllerBase.isTotalOfHoursEditable',
      context: context);

  @override
  bool get isTotalOfHoursEditable {
    _$isTotalOfHoursEditableAtom.reportRead();
    return super.isTotalOfHoursEditable;
  }

  @override
  set isTotalOfHoursEditable(bool value) {
    _$isTotalOfHoursEditableAtom
        .reportWrite(value, super.isTotalOfHoursEditable, () {
      super.isTotalOfHoursEditable = value;
    });
  }

  late final _$readyToSaveAtom = Atom(
      name: 'RegistersEquipmentControllerBase.readyToSave', context: context);

  @override
  bool get readyToSave {
    _$readyToSaveAtom.reportRead();
    return super.readyToSave;
  }

  @override
  set readyToSave(bool value) {
    _$readyToSaveAtom.reportWrite(value, super.readyToSave, () {
      super.readyToSave = value;
    });
  }

  late final _$readyToSendEmailAtom = Atom(
      name: 'RegistersEquipmentControllerBase.readyToSendEmail',
      context: context);

  @override
  bool get readyToSendEmail {
    _$readyToSendEmailAtom.reportRead();
    return super.readyToSendEmail;
  }

  @override
  set readyToSendEmail(bool value) {
    _$readyToSendEmailAtom.reportWrite(value, super.readyToSendEmail, () {
      super.readyToSendEmail = value;
    });
  }

  late final _$isLoadingAtom = Atom(
      name: 'RegistersEquipmentControllerBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$loadOnExportAtom = Atom(
      name: 'RegistersEquipmentControllerBase.loadOnExport', context: context);

  @override
  bool get loadOnExport {
    _$loadOnExportAtom.reportRead();
    return super.loadOnExport;
  }

  @override
  set loadOnExport(bool value) {
    _$loadOnExportAtom.reportWrite(value, super.loadOnExport, () {
      super.loadOnExport = value;
    });
  }

  late final _$loadOnSendAtom = Atom(
      name: 'RegistersEquipmentControllerBase.loadOnSend', context: context);

  @override
  bool get loadOnSend {
    _$loadOnSendAtom.reportRead();
    return super.loadOnSend;
  }

  @override
  set loadOnSend(bool value) {
    _$loadOnSendAtom.reportWrite(value, super.loadOnSend, () {
      super.loadOnSend = value;
    });
  }

  late final _$saveAsyncAction =
      AsyncAction('RegistersEquipmentControllerBase.save', context: context);

  @override
  Future<String> save() {
    return _$saveAsyncAction.run(() => super.save());
  }

  late final _$RegistersEquipmentControllerBaseActionController =
      ActionController(
          name: 'RegistersEquipmentControllerBase', context: context);

  @override
  void setAttendanceStartTimeOfDay(TimeOfDay value) {
    final _$actionInfo =
        _$RegistersEquipmentControllerBaseActionController.startAction(
            name:
                'RegistersEquipmentControllerBase.setAttendanceStartTimeOfDay');
    try {
      return super.setAttendanceStartTimeOfDay(value);
    } finally {
      _$RegistersEquipmentControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void setAttendanceEndTimeOfDay(TimeOfDay value) {
    final _$actionInfo =
        _$RegistersEquipmentControllerBaseActionController.startAction(
            name: 'RegistersEquipmentControllerBase.setAttendanceEndTimeOfDay');
    try {
      return super.setAttendanceEndTimeOfDay(value);
    } finally {
      _$RegistersEquipmentControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void _setTotalOfHours(TimeOfDay? hours) {
    final _$actionInfo = _$RegistersEquipmentControllerBaseActionController
        .startAction(name: 'RegistersEquipmentControllerBase._setTotalOfHours');
    try {
      return super._setTotalOfHours(hours);
    } finally {
      _$RegistersEquipmentControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void calculateHoursDifference() {
    final _$actionInfo =
        _$RegistersEquipmentControllerBaseActionController.startAction(
            name: 'RegistersEquipmentControllerBase.calculateHoursDifference');
    try {
      return super.calculateHoursDifference();
    } finally {
      _$RegistersEquipmentControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void setReadyToSave() {
    final _$actionInfo = _$RegistersEquipmentControllerBaseActionController
        .startAction(name: 'RegistersEquipmentControllerBase.setReadyToSave');
    try {
      return super.setReadyToSave();
    } finally {
      _$RegistersEquipmentControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void setReadyToSendEmail() {
    final _$actionInfo =
        _$RegistersEquipmentControllerBaseActionController.startAction(
            name: 'RegistersEquipmentControllerBase.setReadyToSendEmail');
    try {
      return super.setReadyToSendEmail();
    } finally {
      _$RegistersEquipmentControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
attendanceStartTimeOfDay: ${attendanceStartTimeOfDay},
attendanceEndTimeOfDay: ${attendanceEndTimeOfDay},
totalOfHours: ${totalOfHours},
isTotalOfHoursEditable: ${isTotalOfHoursEditable},
readyToSave: ${readyToSave},
readyToSendEmail: ${readyToSendEmail},
isLoading: ${isLoading},
loadOnExport: ${loadOnExport},
loadOnSend: ${loadOnSend}
    ''';
  }
}
