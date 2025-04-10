import 'package:flutter/material.dart';
import 'package:pokemon_app/modules/home/main.dart';
import 'package:pokemon_app/modules/home/models/main.dart';

class PokemonCardList extends StatelessWidget {
  final Pokemon pokemon;
  const PokemonCardList({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Card(
      key: Key(pokemon.name),
      color: Theme.of(context).colorScheme.surface,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          Navigator.pushNamed(context, HomeModule.detailsRoute, arguments: pokemon);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            spacing: 8,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                pokemon.artwork,
                height: 100,
                width: 100,
              ),
              Text(pokemon.name),
            ],
          ),
        ),
      ),
    );
  }
}
