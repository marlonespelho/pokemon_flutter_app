import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemon_app/generated/l10n.dart';
import 'package:pokemon_app/modules/app_store.dart';
import 'package:pokemon_app/modules/favorite/stores/favorite_store.dart';
import 'package:pokemon_app/modules/home/stores/home_store.dart';
import 'package:pokemon_app/modules/home/views/home_page/pokemon_card_list.dart';

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
      if (homeStore.isLoading && homeStore.pokemonList == null) {
        return buildLoading();
      }
      return buildGrid();
    });
  }

  Widget buildGrid() {
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
                  childAspectRatio: 0.8,
                  controller: scrollController,
                  physics: const BouncingScrollPhysics(),
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    ...homeStore.pokemonList!.map((pokemon) {
                      return PokemonCardList(pokemon: pokemon);
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
}
