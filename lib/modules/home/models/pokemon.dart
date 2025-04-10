import 'package:pokemon_app/core/models/main.dart';

class Pokemon implements ModelInterface {
  final int id;
  final String _name;
  final String _url;

  String get name => _name;
  String get url => _url;

  String get sprite => 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';

  String get artwork =>
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png';

  Pokemon({
    required String name,
    required String url,
    required this.id,
  })  : _name = name,
        _url = url;

  @override
  Pokemon.fromJson(Map<String, dynamic> json)
      : _name = json['name'],
        _url = json['url'],
        id = int.parse(json['url'].split('/')[6]);

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': _name,
      'url': _url,
    };
  }
}
