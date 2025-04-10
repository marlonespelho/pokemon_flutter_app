import 'dart:convert';

import 'package:pokemon_app/core/protocols/use_case.dart';
import 'package:pokemon_app/modules/home/models/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class UpdateFavoriteListUseCaseContract implements UseCase<List<Pokemon>, Pokemon> {}

class SetFavoriteListFromSharedPreferencesUseCase implements UpdateFavoriteListUseCaseContract {
  final SharedPreferences _prefs;

  SetFavoriteListFromSharedPreferencesUseCase({required SharedPreferences prefs}) : _prefs = prefs;

  @override
  Future<List<Pokemon>> execute(Pokemon param) async {
    List<Pokemon> list =
        _prefs.getStringList('favoriteList')?.map((e) => Pokemon.fromJson(jsonDecode(e))).toList() ?? [];
    if (list.any((element) => element.name == param.name)) {
      list.removeWhere((element) => element.name == param.name);
    } else {
      list.add(param);
    }
    await _prefs.setStringList(
      'favoriteList',
      list.map((e) => jsonEncode(e.toJson())).toList(),
    );
    return list;
  }
}

UpdateFavoriteListUseCaseContract updateFavoriteListUseCaseFactory(SharedPreferences prefs) {
  return SetFavoriteListFromSharedPreferencesUseCase(prefs: prefs);
}
