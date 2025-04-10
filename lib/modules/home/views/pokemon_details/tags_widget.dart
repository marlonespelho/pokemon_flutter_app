import 'package:flutter/material.dart';
import 'package:pokemon_app/generated/l10n.dart';
import 'package:pokemon_app/modules/home/models/main.dart';

class TagsWidget extends StatelessWidget {
  final PokemonDetails pokemonDetails;

  const TagsWidget({super.key, required this.pokemonDetails});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: [
        ...pokemonDetails.types
                .map(
                  (type) => buildTagWidget(type.name, context),
                )
                .toList() ??
            [],
        if (pokemonDetails.specie?.isBaby ?? false) buildTagWidget(S.current.babyLabel, context),
        if (pokemonDetails.specie?.isLegendary ?? false) buildTagWidget(S.current.legendaryLabel, context),
        if (pokemonDetails.specie?.isMythical ?? false) buildTagWidget(S.current.mythicalLabel, context),
      ],
    );
  }

  buildTagWidget(String value, BuildContext context) {
    return Chip(
      elevation: 1,
      shadowColor: Colors.white.withValues(alpha: 0.2),
      backgroundColor: pokemonDetails.specie?.getColor()?.withValues(alpha: 0.8),
      label: Text(
        value,
        style: Theme.of(context).textTheme.labelMedium,
      ),
      padding: const EdgeInsets.all(2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(
          color: pokemonDetails.specie?.getColor() ?? Colors.transparent,
        ),
      ),
    );
  }
}
