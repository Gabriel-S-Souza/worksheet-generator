// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'services_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ServicesController on ServicesControllerBase, Store {
  late final _$oilWasUsedAtom =
      Atom(name: 'ServicesControllerBase.oilWasUsed', context: context);

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
      Atom(name: 'ServicesControllerBase.isLoading', context: context);

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
      AsyncAction('ServicesControllerBase.save', context: context);

  @override
  Future<void> save() {
    return _$saveAsyncAction.run(() => super.save());
  }

  late final _$ServicesControllerBaseActionController =
      ActionController(name: 'ServicesControllerBase', context: context);

  @override
  void setOilWasUsed(String value) {
    final _$actionInfo = _$ServicesControllerBaseActionController.startAction(
        name: 'ServicesControllerBase.setOilWasUsed');
    try {
      return super.setOilWasUsed(value);
    } finally {
      _$ServicesControllerBaseActionController.endAction(_$actionInfo);
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
