import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pokemon_app/core/models/model_interface.dart';
import 'package:pokemon_app/modules/home/models/pokedex_number.dart';

class PokemonSpecie implements ModelInterface {
  final int _id;
  final String _name;
  final String _color;
  final List<PokedexNumber> _pokedexNumbers;
  final int captureRate;
  final int baseHappiness;
  final String growthRate;
  final String generation;
  final String? habitat;
  final bool isLegendary;
  final bool isMythical;
  final bool isBaby;

  PokemonSpecie({
    required int id,
    required String name,
    required List<PokedexNumber> pokedexNumbers,
    required String color,
    required this.captureRate,
    required this.baseHappiness,
    required this.growthRate,
    required this.generation,
    required this.habitat,
    required this.isLegendary,
    required this.isMythical,
    required this.isBaby,
  })  : _pokedexNumbers = pokedexNumbers,
        _color = color,
        _name = name,
        _id = id;

  @override
  PokemonSpecie.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _name = json['name'],
        _color = json['color']['name'],
        _pokedexNumbers = (json['pokedex_numbers'] as List).map((item) => PokedexNumber.fromJson(item)).toList(),
        captureRate = json['capture_rate'],
        baseHappiness = json['base_happiness'],
        growthRate = json['growth_rate']['name'],
        generation = json['generation']['name'],
        habitat = json['habitat'] != null ? json['habitat']['name'] : null,
        isLegendary = json['is_legendary'],
        isMythical = json['is_mythical'],
        isBaby = json['is_baby'];

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'name': _name,
      'pokedex_numbers': _pokedexNumbers.map((item) => item.toJson()).toList(),
    };
  }

  getCaptureRate() {
    return captureRate != 0 ? (100 / 255 * captureRate).toStringAsFixed(2) : '0';
  }

  Color? getColor() {
    return {
      'black': Colors.black,
      'blue': Colors.blueAccent,
      'brown': Color(0xFF7C5008),
      'gray': Colors.blueGrey,
      'green': Colors.lightGreen,
      'pink': Colors.pinkAccent[100],
      'purple': Colors.deepPurple,
      'red': Colors.redAccent,
      'white': Color(0xFFF4F4F4),
      'yellow': Color(0xFFf2c12b),
    }[_color];
  }
}
