import 'package:pokemon_app/core/models/main.dart';

class Ability implements ModelInterface {
  final String _name;

  String get name => _name;

  @override
  Ability.fromJson(Map<String, dynamic> json) : _name = json['ability']['name'];

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': _name,
    };
  }
}
