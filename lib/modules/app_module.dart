import 'package:flutter_modular/flutter_modular.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemon_app/core/config/environment.dart';
import 'package:pokemon_app/core/services/poke_api_service.dart';
import 'package:pokemon_app/modules/app_store.dart';
import 'package:pokemon_app/modules/home/main.dart';
import 'package:pokemon_app/modules/home/repositories/poke_api_repository/main.dart';

class AppModule extends Module {
  AppModule() {
    if (!GetIt.I.isRegistered<DefaultPokeAPIRepository>()) {
      GetIt.I.registerSingleton<DefaultPokeAPIRepository>(
        DefaultPokeAPIRepository(
          httpService: PokeAPIHttpService(
            baseUrl: Environment().config.pokeApiBaseUrl,
          ),
        ),
      );
    }
  }

  @override
  List<Bind> get binds => [
        Bind((i) => AppStore()),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(HomeModule.homeRoute, module: HomeModule()),
      ];
}
