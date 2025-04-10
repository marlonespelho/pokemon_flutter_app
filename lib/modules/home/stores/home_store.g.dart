// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on HomeStoreBase, Store {
  Computed<List<Pokemon>?>? _$pokemonListComputed;

  @override
  List<Pokemon>? get pokemonList =>
      (_$pokemonListComputed ??= Computed<List<Pokemon>?>(() => super.pokemonList, name: 'HomeStoreBase.pokemonList'))
          .value;

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

  late final _$paginateAtom = Atom(name: 'HomeStoreBase.paginate', context: context);

  @override
  Paginate? get paginate {
    _$paginateAtom.reportRead();
    return super.paginate;
  }

  @override
  set paginate(Paginate? value) {
    _$paginateAtom.reportWrite(value, super.paginate, () {
      super.paginate = value;
    });
  }

  late final _$getPokemonListAsyncAction = AsyncAction('HomeStoreBase.getPokemonList', context: context);

  @override
  Future getPokemonList() {
    return _$getPokemonListAsyncAction.run(() => super.getPokemonList());
  }

  late final _$getNextPageAsyncAction = AsyncAction('HomeStoreBase.getNextPage', context: context);

  @override
  Future getNextPage() {
    return _$getNextPageAsyncAction.run(() => super.getNextPage());
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
paginate: ${paginate},
pokemonList: ${pokemonList}
    ''';
  }
}
