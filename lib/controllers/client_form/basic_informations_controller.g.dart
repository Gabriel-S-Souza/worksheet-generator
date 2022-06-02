// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basic_informations_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BasicInformaTionsController on BasicInformaTionsControllerBase, Store {
  late final _$maintenanceAtom = Atom(
      name: 'BasicInformaTionsControllerBase.maintenance', context: context);

  @override
  String get maintenance {
    _$maintenanceAtom.reportRead();
    return super.maintenance;
  }

  @override
  set maintenance(String value) {
    _$maintenanceAtom.reportWrite(value, super.maintenance, () {
      super.maintenance = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: 'BasicInformaTionsControllerBase.isLoading', context: context);

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

  late final _$BasicInformaTionsControllerBaseActionController =
      ActionController(
          name: 'BasicInformaTionsControllerBase', context: context);

  @override
  void addToSpreedsheet() {
    final _$actionInfo = _$BasicInformaTionsControllerBaseActionController
        .startAction(name: 'BasicInformaTionsControllerBase.addToSpreedsheet');
    try {
      return super.addToSpreedsheet();
    } finally {
      _$BasicInformaTionsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
maintenance: ${maintenance},
isLoading: ${isLoading}
    ''';
  }
}
