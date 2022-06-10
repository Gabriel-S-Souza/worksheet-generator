// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registers_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RegistersController on RegistersControllerBase, Store {
  late final _$attendanceStartTimeOfDayAtom = Atom(
      name: 'RegistersControllerBase.attendanceStartTimeOfDay',
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
      name: 'RegistersControllerBase.attendanceEndTimeOfDay', context: context);

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

  late final _$totalOfHoursAtom =
      Atom(name: 'RegistersControllerBase.totalOfHours', context: context);

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

  late final _$isLoadingAtom =
      Atom(name: 'RegistersControllerBase.isLoading', context: context);

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

  late final _$saveAsyncAction =
      AsyncAction('RegistersControllerBase.save', context: context);

  @override
  Future<void> save() {
    return _$saveAsyncAction.run(() => super.save());
  }

  late final _$RegistersControllerBaseActionController =
      ActionController(name: 'RegistersControllerBase', context: context);

  @override
  void _setTotalOfHours(TimeOfDay? hours) {
    final _$actionInfo = _$RegistersControllerBaseActionController.startAction(
        name: 'RegistersControllerBase._setTotalOfHours');
    try {
      return super._setTotalOfHours(hours);
    } finally {
      _$RegistersControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
attendanceStartTimeOfDay: ${attendanceStartTimeOfDay},
attendanceEndTimeOfDay: ${attendanceEndTimeOfDay},
totalOfHours: ${totalOfHours},
isLoading: ${isLoading}
    ''';
  }
}
