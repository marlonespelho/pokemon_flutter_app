// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apod_favorite_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$APODFavoriteStore on APODFavoriteStoreBase, Store {
  late final _$favoriteListAtom = Atom(name: 'APODFavoriteStoreBase.favoriteList', context: context);

  @override
  List<APODNasaModel> get favoriteList {
    _$favoriteListAtom.reportRead();
    return super.favoriteList;
  }

  @override
  set favoriteList(List<APODNasaModel> value) {
    _$favoriteListAtom.reportWrite(value, super.favoriteList, () {
      super.favoriteList = value;
    });
  }

  late final _$loadingAtom = Atom(name: 'APODFavoriteStoreBase.loading', context: context);

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  late final _$isFavoriteAtom = Atom(name: 'APODFavoriteStoreBase.isFavorite', context: context);

  @override
  bool get isFavorite {
    _$isFavoriteAtom.reportRead();
    return super.isFavorite;
  }

  @override
  set isFavorite(bool value) {
    _$isFavoriteAtom.reportWrite(value, super.isFavorite, () {
      super.isFavorite = value;
    });
  }

  late final _$APODFavoriteStoreBaseActionController =
      ActionController(name: 'APODFavoriteStoreBase', context: context);

  @override
  dynamic setIsFavorite(APODNasaModel apod) {
    final _$actionInfo =
        _$APODFavoriteStoreBaseActionController.startAction(name: 'APODFavoriteStoreBase.setIsFavorite');
    try {
      return super.setIsFavorite(apod);
    } finally {
      _$APODFavoriteStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
favoriteList: ${favoriteList},
loading: ${loading},
isFavorite: ${isFavorite}
    ''';
  }
}
