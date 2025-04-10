import 'package:pokemon_app/core/models/main.dart';

class Pokedex implements ModelInterface {
  final String name;
  final String url;

  Pokedex({required this.name, required this.url});

  @override
  Pokedex.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        url = json['url'];

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
    };
  }
}
