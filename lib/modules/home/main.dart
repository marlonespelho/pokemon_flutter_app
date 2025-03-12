import 'package:flutter_modular/flutter_modular.dart';
import 'package:get_it/get_it.dart';
import 'package:nasa_daily_app/modules/home/repositories/nasa_repository/main.dart';
import 'package:nasa_daily_app/modules/home/stores/apod_favorite_store.dart';
import 'package:nasa_daily_app/modules/home/stores/home_store.dart';
import 'package:nasa_daily_app/modules/home/use_cases/main.dart';
import 'package:nasa_daily_app/modules/home/views/favorite_page/main.dart';
import 'package:nasa_daily_app/modules/home/views/home_page/main.dart';

class HomeModule extends Module {
  static const String homeRoute = "/home";
  static const String favoriteRoute = "/home/favorite";

  @override
  List<Bind> get binds => [
        Bind((i) => nasaRepositoryFactory(i.get())),
        Bind((i) => getNasaAPODUseCaseFactory(i.get())),
        Bind((i) => getAPODFavoriteListUseCaseFactory(
              GetIt.I.get(),
            )),
        Bind((i) => updateAPODFavoriteListUseCaseFactory(
              GetIt.I.get(),
            )),
        Bind(
          (i) => APODFavoriteStore(getAPODFavoriteListUseCase: i.get(), updateAPODFavoriteListUseCase: i.get()),
        ),
        Bind(
          (i) => HomeStore(getNasaAPODUseCase: i.get()),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute("/", child: (_, args) => const HomePage()),
        ChildRoute("/favorite", child: (_, args) => const FavoritePage()),
      ];
}
