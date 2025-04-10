import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemon_app/core/design/theme/palette.dart';
import 'package:pokemon_app/generated/l10n.dart';
import 'package:pokemon_app/modules/favorite/widgets/favorite_icon_widget.dart';
import 'package:pokemon_app/modules/home/models/main.dart';
import 'package:pokemon_app/modules/home/stores/pokemon_details_store.dart';
import 'package:pokemon_app/modules/home/views/pokemon_details/about_tab_widget.dart';
import 'package:pokemon_app/modules/home/views/pokemon_details/stats_tab_widget.dart';
import 'package:pokemon_app/modules/home/views/pokemon_details/tags_widget.dart';

class PokemonDetailsPage extends StatefulWidget {
  final Pokemon pokemon;

  const PokemonDetailsPage({super.key, required this.pokemon});

  @override
  State<PokemonDetailsPage> createState() => _PokemonDetailsPageState();
}

class _PokemonDetailsPageState extends State<PokemonDetailsPage> {
  final PokemonDetailsStore store = GetIt.I<PokemonDetailsStore>();

  @override
  void initState() {
    store.pokemonDetails = null;
    super.initState();
    Future.microtask(() {
      store.getPokemonDetails(widget.pokemon.name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Scaffold(
        backgroundColor: store.pokemonDetails?.specie?.getColor() ?? Colors.white,
        appBar: buildAppBar(context),
        body: buildContent(),
      );
    });
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Palette.primaryTextColor,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      backgroundColor: Colors.transparent,
      actions: [
        FavoriteIconWidget(pokemon: widget.pokemon),
      ],
    );
  }

  buildContent() {
    return Observer(builder: (context) {
      if (store.isLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return Align(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            buildTitle(),
            Image.network(
              store.pokemonDetails?.sprites.officialArtwork ?? '',
              height: 200,
              width: 200,
            ),
            buildDetails(),
          ],
        ),
      );
    });
  }

  Widget buildTitle() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                store.pokemonDetails?.name ?? '',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 40,
                    ),
              ),
              if (store.pokemonDetails != null) TagsWidget(pokemonDetails: store.pokemonDetails!),
            ],
          ),
          Text(
            '#${store.pokemonDetails?.id.toString().padLeft(3, '0') ?? ''}',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
    );
  }

  buildDetails() {
    return Expanded(
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.only(top: 8),
          alignment: Alignment.bottomCenter,
          child: Card(
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(40),
              ),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildDefaultTabController(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDefaultTabController() {
    return DefaultTabController(
      length: 2,
      child: Column(
        spacing: 32,
        children: [
          TabBar(
            tabs: [
              Tab(text: S.current.aboutLabel),
              Tab(text: S.current.statsLabel),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: TabBarView(
              children: [
                if (store.pokemonDetails != null) ...[
                  AboutTabWidget(pokemonDetails: store.pokemonDetails!),
                  StatsTabWidget(stats: store.pokemonDetails!.stats),
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }
}
