// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'services_equipment_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ServicesEquipmentController on ServicesEquipmentControllerBase, Store {
  late final _$oilWasUsedAtom = Atom(
      name: 'ServicesEquipmentControllerBase.oilWasUsed', context: context);

  @override
  String get oilWasUsed {
    _$oilWasUsedAtom.reportRead();
    return super.oilWasUsed;
  }

  @override
  set oilWasUsed(String value) {
    _$oilWasUsedAtom.reportWrite(value, super.oilWasUsed, () {
      super.oilWasUsed = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: 'ServicesEquipmentControllerBase.isLoading', context: context);

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
      AsyncAction('ServicesEquipmentControllerBase.save', context: context);

  @override
  Future<void> save() {
    return _$saveAsyncAction.run(() => super.save());
  }

  late final _$ServicesEquipmentControllerBaseActionController =
      ActionController(
          name: 'ServicesEquipmentControllerBase', context: context);

  @override
  void setOilWasUsed(String value) {
    final _$actionInfo = _$ServicesEquipmentControllerBaseActionController
        .startAction(name: 'ServicesEquipmentControllerBase.setOilWasUsed');
    try {
      return super.setOilWasUsed(value);
    } finally {
      _$ServicesEquipmentControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
oilWasUsed: ${oilWasUsed},
isLoading: ${isLoading}
    ''';
  }
}
