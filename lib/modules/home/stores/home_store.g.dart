// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on HomeStoreBase, Store {
  late final _$isLoadingAtom = Atom(name: 'HomeStoreBase.isLoading', context: context);

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

  late final _$showHDAtom = Atom(name: 'HomeStoreBase.showHD', context: context);

  @override
  bool get showHD {
    _$showHDAtom.reportRead();
    return super.showHD;
  }

  @override
  set showHD(bool value) {
    _$showHDAtom.reportWrite(value, super.showHD, () {
      super.showHD = value;
    });
  }

  late final _$apodNasaAtom = Atom(name: 'HomeStoreBase.apodNasa', context: context);

  @override
  APODNasaModel? get apodNasa {
    _$apodNasaAtom.reportRead();
    return super.apodNasa;
  }

  @override
  set apodNasa(APODNasaModel? value) {
    _$apodNasaAtom.reportWrite(value, super.apodNasa, () {
      super.apodNasa = value;
    });
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
showHD: ${showHD},
apodNasa: ${apodNasa}
    ''';
  }
}
