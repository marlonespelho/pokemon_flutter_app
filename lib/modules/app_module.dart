import 'package:flutter_modular/flutter_modular.dart';
import 'package:pokemon_app/core/config/environment.dart';
import 'package:pokemon_app/core/services/poke_api_service.dart';
import 'package:pokemon_app/modules/app_store.dart';
import 'package:pokemon_app/modules/home/main.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => PokeAPIHttpService(baseUrl: Environment().config.pokeApiBaseUrl)),
        Bind((i) => AppStore()),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(HomeModule.homeRoute, module: HomeModule()),
      ];
}
