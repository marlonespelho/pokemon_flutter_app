import 'package:flutter_modular/flutter_modular.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemon_app/modules/favorite/stores/favorite_store.dart';
import 'package:pokemon_app/modules/favorite/use_cases/get_favorite_list_use_case.dart';
import 'package:pokemon_app/modules/favorite/use_cases/update_favorite_list_use_case.dart';
import 'package:pokemon_app/modules/favorite/views/favorite_page/main.dart';

class FavoriteModule extends Module {
  static const String favoritesRoute = "/favorites";

  @override
  List<Bind> get binds => [
        Bind.singleton((i) => getFavoriteListUseCaseFactory(GetIt.I.get()), export: true),
        Bind.singleton((i) => updateFavoriteListUseCaseFactory(GetIt.I.get()), export: true),
        Bind.singleton(
          (i) => FavoriteStore(
            getFavoriteListUseCase: i.get(),
            updateFavoriteListUseCase: i.get(),
          ),
          export: true,
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, args) => const FavoritePage()),
      ];
}
