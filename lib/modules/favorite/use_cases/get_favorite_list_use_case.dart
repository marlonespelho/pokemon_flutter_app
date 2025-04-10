import 'dart:convert';

import 'package:pokemon_app/core/protocols/use_case.dart';
import 'package:pokemon_app/modules/home/models/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class GetFavoriteListUseCaseContract implements UseCase<List<Pokemon>, void> {}

class GetFavoriteListFromSharedPreferencesUseCase implements GetFavoriteListUseCaseContract {
  final SharedPreferences _prefs;
  GetFavoriteListFromSharedPreferencesUseCase({required SharedPreferences prefs}) : _prefs = prefs;

  @override
  Future<List<Pokemon>> execute(void param) async {
    return _prefs.getStringList('favoriteList')?.map((e) => Pokemon.fromJson(jsonDecode(e))).toList() ?? [];
  }
}

GetFavoriteListUseCaseContract getFavoriteListUseCaseFactory(SharedPreferences prefs) {
  return GetFavoriteListFromSharedPreferencesUseCase(prefs: prefs);
}
