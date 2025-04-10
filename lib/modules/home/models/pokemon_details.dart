import 'package:pokemon_app/core/models/main.dart';
import 'package:pokemon_app/modules/home/models/main.dart';

class PokemonDetails implements ModelInterface {
  final int _id;
  final String _name;
  final int _baseExperience;
  final int _height;
  final int _weight;
  final List<Ability> _abilities;
  final List<PokemonType> _types;
  final Sprites _sprites;
  final List<Stat> _stats;
  PokemonSpecie? _specie;

  PokemonDetails({
    required int id,
    required String name,
    required int baseExperience,
    required int height,
    required int weight,
    required List<Ability> abilities,
    required List<PokemonType> types,
    required Sprites sprites,
    required List<Stat> stats,
    PokemonSpecie? specie,
  })  : _id = id,
        _name = name,
        _baseExperience = baseExperience,
        _height = height,
        _weight = weight,
        _abilities = abilities,
        _types = types,
        _sprites = sprites,
        _stats = stats,
        _specie = specie;

  int get id => _id;
  String get name => _name;
  int get baseExperience => _baseExperience;
  double get height => _height * 10;
  double get weight => _weight / 10;
  List<Ability> get abilities => _abilities;
  List<PokemonType> get types => _types;
  Sprites get sprites => _sprites;
  List<Stat> get stats => _stats;
  PokemonSpecie? get specie => _specie;

  set specie(PokemonSpecie? specie) => _specie = specie;

  @override
  PokemonDetails.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _name = json['name'],
        _baseExperience = json['base_experience'],
        _height = json['height'],
        _weight = json['weight'],
        _abilities = (json['abilities'] as List).map((ability) => Ability.fromJson(ability)).toList(),
        _types = (json['types'] as List).map((type) => PokemonType.fromJson(type)).toList(),
        _sprites = Sprites.fromJson(json['sprites']),
        _stats = (json['stats'] as List).map((stat) => Stat.fromJson(stat)).toList(),
        _specie = json['specie'] != null ? PokemonSpecie.fromJson(json['specie']) : null;

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'name': _name,
      'base_experience': _baseExperience,
      'height': _height,
      'weight': _weight,
      'abilities': _abilities.map((ability) => ability.toJson()).toList(),
      'types': _types.map((type) => type.toJson()).toList(),
      'sprites': _sprites.toJson(),
      'stats': _stats.map((stat) => stat.toJson()).toList(),
    };
  }
}
