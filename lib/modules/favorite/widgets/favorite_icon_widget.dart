import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pokemon_app/core/design/widgets/main.dart';
import 'package:pokemon_app/core/services/main.dart';
import 'package:pokemon_app/generated/l10n.dart';
import 'package:pokemon_app/modules/favorite/stores/favorite_store.dart';
import 'package:pokemon_app/modules/home/models/main.dart';

class FavoriteIconWidget extends StatelessWidget {
  final Pokemon pokemon;
  final FavoriteStore favoriteStore = Modular.get();

  FavoriteIconWidget({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return AnimatedColorIcon(
        icon: Icons.favorite,
        selected: favoriteStore.favoriteList.any(
          (element) => element.name == pokemon.name,
        ),
        onTap: () {
          favoriteStore.updateFavoriteList(pokemon, callback: (bool added) {
            NativeToast.showToast(
              added ? S.current.addToFavoriteMessage(pokemon.name) : S.current.removeFromFavoriteMessage(pokemon.name),
            );
          });
        },
      );
    });
  }
}
