import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemon_app/core/design/assets/icons/icons_path.dart';
import 'package:pokemon_app/generated/l10n.dart';
import 'package:pokemon_app/modules/app_store.dart';
import 'package:pokemon_app/modules/home/models/pokemon.dart';
import 'package:pokemon_app/modules/home/stores/home_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeStore homeStore = GetIt.I.get<HomeStore>();
  final AppStore appStore = Modular.get();

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      scrollController.addListener(() {
        if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
          homeStore.getNextPage();
        }
      });
      homeStore.getPokemonList();
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildContent(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(S.current.homeAppBarTitle),
      actions: [
        IconButton(
          onPressed: () {
            appStore.changeThemeMode();
          },
          icon: buildThemeModeAction(),
        ),
        IconButton(
          key: const Key("favoritePageButton"),
          onPressed: () {},
          icon: Icon(
            Icons.favorite,
          ),
        ),
      ],
    );
  }

  Observer buildThemeModeAction() {
    return Observer(builder: (context) {
      return Icon(
        appStore.themeMode == ThemeMode.light ? Icons.dark_mode : Icons.light_mode,
      );
    });
  }

  Observer buildContent() {
    return Observer(builder: (context) {
      return buildList();
    });
  }

  Widget buildList() {
    if (homeStore.isLoading && homeStore.pokemonList == null) {
      return buildLoading();
    }
    return (homeStore.pokemonList?.isEmpty ?? true)
        ? Center(
            child: Text(S.current.homeEmptyList),
          )
        : RefreshIndicator(
            onRefresh: () async {
              if (homeStore.isLoading) return;
              await homeStore.getPokemonList();
            },
            child: Scrollbar(
              controller: scrollController,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GridView.count(
                  crossAxisCount: 2,
                  controller: scrollController,
                  physics: const BouncingScrollPhysics(),
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    ...homeStore.pokemonList!.map((pokemon) {
                      return buildPokemonCardList(pokemon);
                    }),
                  ],
                ),
              ),
            ),
          );
  }

  Widget buildLoading() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 32),
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: CircularProgressIndicator(),
    );
  }

  Card buildPokemonCardList(Pokemon pokemon) {
    return Card(
      color: Theme.of(context).colorScheme.surface,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {},
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
