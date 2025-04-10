import 'package:flutter/material.dart';
import 'package:pokemon_app/core/design/widgets/main.dart';
import 'package:pokemon_app/generated/l10n.dart';
import 'package:pokemon_app/modules/home/models/main.dart';

class AboutTabWidget extends StatelessWidget {
  final PokemonDetails pokemonDetails;

  const AboutTabWidget({super.key, required this.pokemonDetails});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          RowTextLabel(
            label: S.current.generationLabel,
            value: pokemonDetails.specie?.generation,
          ),
          RowTextLabel(
            label: S.current.heightLabel,
            value: '${pokemonDetails.height.toString() ?? ''} cm',
          ),
          RowTextLabel(
            label: S.current.weightLabel,
            value: '${pokemonDetails.weight.toString() ?? ''} kg',
          ),
          RowTextLabel(
            label: S.current.baseExperienceLabel,
            value: pokemonDetails.baseExperience.toString() ?? '',
          ),
          RowTextLabel(
            label: S.current.growRateLabel,
            value: pokemonDetails.specie?.growthRate,
          ),
          RowTextLabel(
            label: S.current.captureRateLabel,
            value: "${pokemonDetails.specie?.getCaptureRate() ?? ''}%",
          ),
          RowTextLabel(
            label: S.current.abilitiesLabel,
            value: pokemonDetails.abilities.map((ability) => ability.name).toList().join(', '),
          ),
          if (pokemonDetails.specie?.habitat != null)
            RowTextLabel(
              label: S.current.habitatLabel,
              value: pokemonDetails.specie?.habitat,
            ),
        ],
      ),
    );
  }
}
