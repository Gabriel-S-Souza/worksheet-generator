// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basic_info_equipment_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BasicInfoEquipmentController
    on BasicInfoEquipmentControllerBase, Store {
  late final _$isAutoOSAtom =
      Atom(name: 'BasicInfoEquipmentControllerBase.isAutoOS', context: context);

  @override
  bool get isAutoOS {
    _$isAutoOSAtom.reportRead();
    return super.isAutoOS;
  }

  @override
  set isAutoOS(bool value) {
    _$isAutoOSAtom.reportWrite(value, super.isAutoOS, () {
      super.isAutoOS = value;
    });
  }

  late final _$osWasGeneratedAtom = Atom(
      name: 'BasicInfoEquipmentControllerBase.osWasGenerated',
      context: context);

  @override
  bool get osWasGenerated {
    _$osWasGeneratedAtom.reportRead();
    return super.osWasGenerated;
  }

  @override
  set osWasGenerated(bool value) {
    _$osWasGeneratedAtom.reportWrite(value, super.osWasGenerated, () {
      super.osWasGenerated = value;
    });
  }

  late final _$isCorrectiveAtom = Atom(
      name: 'BasicInfoEquipmentControllerBase.isCorrective', context: context);

  @override
  bool get isCorrective {
    _$isCorrectiveAtom.reportRead();
    return super.isCorrective;
  }

  @override
  set isCorrective(bool value) {
    _$isCorrectiveAtom.reportWrite(value, super.isCorrective, () {
      super.isCorrective = value;
    });
  }

  late final _$isExcavatorAtom = Atom(
      name: 'BasicInfoEquipmentControllerBase.isExcavator', context: context);

  @override
  bool get isExcavator {
    _$isExcavatorAtom.reportRead();
    return super.isExcavator;
  }

  @override
  set isExcavator(bool value) {
    _$isExcavatorAtom.reportWrite(value, super.isExcavator, () {
      super.isExcavator = value;
    });
  }

  late final _$isScissorsAtom = Atom(
      name: 'BasicInfoEquipmentControllerBase.isScissors', context: context);

  @override
  bool get isScissors {
    _$isScissorsAtom.reportRead();
    return super.isScissors;
  }

  @override
  set isScissors(bool value) {
    _$isScissorsAtom.reportWrite(value, super.isScissors, () {
      super.isScissors = value;
    });
  }

  late final _$isLoadingAtom = Atom(
      name: 'BasicInfoEquipmentControllerBase.isLoading', context: context);

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
      AsyncAction('BasicInfoEquipmentControllerBase.save', context: context);

  @override
  Future<void> save() {
    return _$saveAsyncAction.run(() => super.save());
  }

  late final _$BasicInfoEquipmentControllerBaseActionController =
      ActionController(
          name: 'BasicInfoEquipmentControllerBase', context: context);

  @override
  void reset() {
    final _$actionInfo = _$BasicInfoEquipmentControllerBaseActionController
        .startAction(name: 'BasicInfoEquipmentControllerBase.reset');
    try {
      return super.reset();
    } finally {
      _$BasicInfoEquipmentControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void generateOs() {
    final _$actionInfo = _$BasicInfoEquipmentControllerBaseActionController
        .startAction(name: 'BasicInfoEquipmentControllerBase.generateOs');
    try {
      return super.generateOs();
    } finally {
      _$BasicInfoEquipmentControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isAutoOS: ${isAutoOS},
osWasGenerated: ${osWasGenerated},
isCorrective: ${isCorrective},
isExcavator: ${isExcavator},
isScissors: ${isScissors},
isLoading: ${isLoading}
    ''';
  }
}
