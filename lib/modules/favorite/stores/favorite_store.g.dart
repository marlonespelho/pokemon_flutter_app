// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FavoriteStore on FavoriteStoreBase, Store {
  late final _$favoriteListAtom = Atom(name: 'FavoriteStoreBase.favoriteList', context: context);

  @override
  List<Pokemon> get favoriteList {
    _$favoriteListAtom.reportRead();
    return super.favoriteList;
  }

  @override
  set favoriteList(List<Pokemon> value) {
    _$favoriteListAtom.reportWrite(value, super.favoriteList, () {
      super.favoriteList = value;
    });
  }

  late final _$loadingAtom = Atom(name: 'FavoriteStoreBase.loading', context: context);

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

  late final _$FavoriteStoreBaseActionController = ActionController(name: 'FavoriteStoreBase', context: context);

  @override
  dynamic isFavorite(Pokemon pokemon) {
    final _$actionInfo = _$FavoriteStoreBaseActionController.startAction(name: 'FavoriteStoreBase.isFavorite');
    try {
      return super.isFavorite(pokemon);
    } finally {
      _$FavoriteStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
favoriteList: ${favoriteList},
loading: ${loading}
    ''';
  }
}
