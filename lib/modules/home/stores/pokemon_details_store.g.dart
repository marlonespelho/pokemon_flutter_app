// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_details_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PokemonDetailsStore on PokemonDetailsStoreBase, Store {
  late final _$isLoadingAtom = Atom(name: 'PokemonDetailsStoreBase.isLoading', context: context);

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

  late final _$pokemonDetailsAtom = Atom(name: 'PokemonDetailsStoreBase.pokemonDetails', context: context);

  @override
  PokemonDetails? get pokemonDetails {
    _$pokemonDetailsAtom.reportRead();
    return super.pokemonDetails;
  }

  @override
  set pokemonDetails(PokemonDetails? value) {
    _$pokemonDetailsAtom.reportWrite(value, super.pokemonDetails, () {
      super.pokemonDetails = value;
    });
  }

  late final _$getPokemonDetailsAsyncAction =
      AsyncAction('PokemonDetailsStoreBase.getPokemonDetails', context: context);

  @override
  Future getPokemonDetails(String name) {
    return _$getPokemonDetailsAsyncAction.run(() => super.getPokemonDetails(name));
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
pokemonDetails: ${pokemonDetails}
    ''';
  }
}
