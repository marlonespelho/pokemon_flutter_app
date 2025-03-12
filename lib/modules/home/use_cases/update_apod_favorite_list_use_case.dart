import 'dart:convert';

import 'package:nasa_daily_app/core/protocols/use_case.dart';
import 'package:nasa_daily_app/modules/home/models/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class UpdateAPODFavoriteListUseCaseContract implements UseCase<List<APODNasaModel>, APODNasaModel> {}

class SetAPODFavoriteListFromSharedPreferencesUseCase implements UpdateAPODFavoriteListUseCaseContract {
  final SharedPreferences _prefs;

  SetAPODFavoriteListFromSharedPreferencesUseCase({required SharedPreferences prefs}) : _prefs = prefs;

  @override
  Future<List<APODNasaModel>> execute(APODNasaModel param) async {
    List<APODNasaModel> list =
        _prefs.getStringList('favoriteList')?.map((e) => APODNasaModel.fromJson(jsonDecode(e))).toList() ?? [];
    if (list.any((element) => element.date == param.date)) {
      list.removeWhere((element) => element.date == param.date);
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

UpdateAPODFavoriteListUseCaseContract updateAPODFavoriteListUseCaseFactory(SharedPreferences prefs) {
  return SetAPODFavoriteListFromSharedPreferencesUseCase(prefs: prefs);
}
