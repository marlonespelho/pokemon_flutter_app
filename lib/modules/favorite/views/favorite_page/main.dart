import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pokemon_app/generated/l10n.dart';
import 'package:pokemon_app/modules/favorite/stores/favorite_store.dart';
import 'package:pokemon_app/modules/home/views/home_page/pokemon_card_list.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final FavoriteStore favoriteStore = Modular.get();
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.favoritePageTitle),
      ),
      body: buildContent(),
    );
  }

  Observer buildContent() {
    return Observer(builder: (context) {
      if (favoriteStore.loading) {
        return buildLoading();
      }
      return buildGrid();
    });
  }

  Widget buildGrid() {
    return favoriteStore.favoriteList.isEmpty
        ? Center(
            child: Text(
              S.current.favoritePageEmptyList,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 20,
                  ),
            ),
          )
        : RefreshIndicator(
            onRefresh: () async {
              if (favoriteStore.loading) return;
              await favoriteStore.getFavoriteList();
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
                    ...favoriteStore.favoriteList.map((pokemon) {
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
