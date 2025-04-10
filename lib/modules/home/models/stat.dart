import 'package:pokemon_app/core/models/main.dart';

class Stat implements ModelInterface {
  final String _name;
  final int _baseStat;

  Stat({required String name, required int baseStat})
      : _name = name,
        _baseStat = baseStat;

  String get name => _name;
  int get baseStat => _baseStat;

  @override
  Stat.fromJson(Map<String, dynamic> json)
      : _name = json['stat']['name'],
        _baseStat = json['base_stat'];

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': _name,
      'base_stat': _baseStat,
    };
  }
}
