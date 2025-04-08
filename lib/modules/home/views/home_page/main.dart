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

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      homeStore.getPokemonList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            icon: SvgPicture.asset(
              IconsPath.favoriteListIcon,
            ),
          ),
        ],
      ),
      body: buildContent(),
    );
  }

  Observer buildThemeModeAction() {
    return Observer(builder: (context) {
      return Icon(
        appStore.themeMode == ThemeMode.light
            ? Icons.dark_mode
            : Icons.light_mode,
      );
    });
  }

  Observer buildContent() {
    return Observer(builder: (context) {
      return homeStore.isLoading
          ? Container(
              height: MediaQuery.of(context).size.height,
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: homeStore.pokemonList!.map((pokemon) {
                  return buildPokemonCardList(pokemon);
                }).toList(),
              ),
            );
    });
  }

  Card buildPokemonCardList(Pokemon pokemon) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 8,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              pokemon.spriteUrl,
              height: 100,
              width: 100,
            ),
            Text(pokemon.name),
          ],
        ),
      ),
    );
  }
}
