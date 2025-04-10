import 'package:pokemon_app/core/models/main.dart';
import 'package:pokemon_app/modules/home/models/pokedex.dart';

class PokedexNumber implements ModelInterface {
  final int entryNumber;
  final Pokedex pokedex;

  PokedexNumber({required this.entryNumber, required this.pokedex});

  @override
  PokedexNumber.fromJson(Map<String, dynamic> json)
      : entryNumber = json['entry_number'],
        pokedex = Pokedex.fromJson(json['pokedex']);

  @override
  Map<String, dynamic> toJson() {
    return {
      'entry_number': entryNumber,
      'pokedex': pokedex.toJson(),
    };
  }
}
