import 'package:flutter_modular/flutter_modular.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemon_app/modules/home/repositories/poke_api_repository/main.dart';
import 'package:pokemon_app/modules/home/stores/home_store.dart';
import 'package:pokemon_app/modules/home/use_cases/get_pokemon_list_use_case.dart';
import 'package:pokemon_app/modules/home/views/home_page/main.dart';

class HomeModule extends Module {
  static const String homeRoute = "/home";
  static const String favoriteRoute = "/home/favorite";

  HomeModule() {
    if (!GetIt.I.isRegistered<DefaultGetPokemonListUseCase>()) {
      GetIt.I.registerSingleton<DefaultGetPokemonListUseCase>(
          DefaultGetPokemonListUseCase(
        repository: GetIt.I.get<DefaultPokeAPIRepository>(),
      ));
    }
    if (!GetIt.I.isRegistered<HomeStore>()) {
      GetIt.I.registerSingleton<HomeStore>(HomeStore(
        getPokemonListUseCase: GetIt.I.get<DefaultGetPokemonListUseCase>(),
      ));
    }
  }

  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute("/", child: (_, args) => const HomePage()),
      ];
}
