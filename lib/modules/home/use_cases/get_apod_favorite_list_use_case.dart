import 'dart:convert';

import 'package:nasa_daily_app/core/protocols/use_case.dart';
import 'package:nasa_daily_app/modules/home/models/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class GetAPODFavoriteListUseCaseContract implements UseCase<List<APODNasaModel>, void> {}

class GetAPODFavoriteListFromSharedPreferencesUseCase implements GetAPODFavoriteListUseCaseContract {
  final SharedPreferences _prefs;
  GetAPODFavoriteListFromSharedPreferencesUseCase({required SharedPreferences prefs}) : _prefs = prefs;

  @override
  Future<List<APODNasaModel>> execute(void param) async {
    return _prefs.getStringList('favoriteList')?.map((e) => APODNasaModel.fromJson(jsonDecode(e))).toList() ?? [];
  }
}

GetAPODFavoriteListUseCaseContract getAPODFavoriteListUseCaseFactory(SharedPreferences prefs) {
  return GetAPODFavoriteListFromSharedPreferencesUseCase(prefs: prefs);
}
