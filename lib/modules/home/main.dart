import 'package:flutter_modular/flutter_modular.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemon_app/modules/home/repositories/poke_api_repository/main.dart';
import 'package:pokemon_app/modules/home/stores/home_store.dart';
import 'package:pokemon_app/modules/home/stores/pokemon_details_store.dart';
import 'package:pokemon_app/modules/home/use_cases/main.dart';
import 'package:pokemon_app/modules/home/views/home_page/main.dart';
import 'package:pokemon_app/modules/home/views/pokemon_details/main.dart';

class HomeModule extends Module {
  static const String homeRoute = "/home";
  static const String detailsRoute = "/home/details";

  HomeModule() {
    if (!GetIt.I.isRegistered<DefaultGetPokemonListUseCase>()) {
      GetIt.I.registerSingleton<DefaultGetPokemonListUseCase>(DefaultGetPokemonListUseCase(
        repository: GetIt.I.get<DefaultPokeAPIRepository>(),
      ));
    }

    if (!GetIt.I.isRegistered<HomeStore>()) {
      GetIt.I.registerSingleton<HomeStore>(HomeStore(
        getPokemonListUseCase: GetIt.I.get<DefaultGetPokemonListUseCase>(),
      ));
    }

    if (!GetIt.I.isRegistered<DefaultGetPokemonDetailsUseCase>()) {
      GetIt.I.registerSingleton<DefaultGetPokemonDetailsUseCase>(DefaultGetPokemonDetailsUseCase(
        repository: GetIt.I.get<DefaultPokeAPIRepository>(),
      ));
    }

    if (!GetIt.I.isRegistered<PokemonDetailsStore>()) {
      GetIt.I.registerSingleton<PokemonDetailsStore>(PokemonDetailsStore(
        getPokemonDetailsUseCase: GetIt.I.get<DefaultGetPokemonDetailsUseCase>(),
      ));
    }
  }

  @override
  List<Bind> get binds => [
        Bind.lazySingleton<DefaultGetPokemonDetailsUseCase>((i) => DefaultGetPokemonDetailsUseCase(
              repository: GetIt.I.get<DefaultPokeAPIRepository>(),
            )),
        Bind.lazySingleton<PokemonDetailsStore>((i) => PokemonDetailsStore(
              getPokemonDetailsUseCase: i.get(),
            )),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute("/", child: (_, args) => const HomePage()),
        ChildRoute("/details", child: (_, args) {
          return PokemonDetailsPage(
            pokemon: args.data,
          );
        }),
      ];
}
