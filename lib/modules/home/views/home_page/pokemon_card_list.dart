import 'package:flutter/material.dart';
import 'package:pokemon_app/core/design/widgets/main.dart';
import 'package:pokemon_app/modules/favorite/widgets/favorite_icon_widget.dart';
import 'package:pokemon_app/modules/home/main.dart';
import 'package:pokemon_app/modules/home/models/main.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PokemonCardList extends StatefulWidget {
  final Pokemon pokemon;

  const PokemonCardList({super.key, required this.pokemon});

  @override
  State<PokemonCardList> createState() => _PokemonCardListState();
}

class _PokemonCardListState extends State<PokemonCardList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      key: Key(widget.pokemon.name),
      color: Theme.of(context).colorScheme.surface,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          Navigator.pushNamed(
            context,
            HomeModule.detailsRoute,
            arguments: widget.pokemon,
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            spacing: 8,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildHeader(context),
              Expanded(
                child: CachedNetworkImage(
                  imageUrl: widget.pokemon.artwork,
                  height: 100,
                  width: 100,
                  progressIndicatorBuilder: (_, __, progress) => Center(
                    child: ShimmerLoading(height: 100, width: 100),
                  ),
                  errorWidget: (_, __, error) => const Icon(Icons.error),
                ),
              ),
              Text(widget.pokemon.name),
            ],
          ),
        ),
      ),
    );
  }

  Row buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            '#${widget.pokemon.id.toString().padLeft(3, '0')}',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        Flexible(
          child: FavoriteIconWidget(pokemon: widget.pokemon),
        ),
      ],
    );
  }
}
