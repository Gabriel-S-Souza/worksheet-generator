// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basic_informations_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BasicInformaTionsController on BasicInformaTionsControllerBase, Store {
  late final _$isAutoOSAtom =
      Atom(name: 'BasicInformaTionsControllerBase.isAutoOS', context: context);

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

  late final _$isCorrectiveAtom = Atom(
      name: 'BasicInformaTionsControllerBase.isCorrective', context: context);

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

  late final _$saveAsyncAction =
      AsyncAction('BasicInformaTionsControllerBase.save', context: context);

  @override
  Future<void> save() {
    return _$saveAsyncAction.run(() => super.save());
  }

  @override
  String toString() {
    return '''
isAutoOS: ${isAutoOS},
isCorrective: ${isCorrective},
isLoading: ${isLoading}
    ''';
  }
}
