import 'package:pokemon_app/core/models/main.dart';

class PokemonType implements ModelInterface {
  final String _name;

  PokemonType({required String name}) : _name = name;
  String get name => _name;

  @override
  PokemonType.fromJson(Map<String, dynamic> json) : _name = json['type']['name'];

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': _name,
    };
  }
}
