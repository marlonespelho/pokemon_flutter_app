import 'package:mobx/mobx.dart';
import 'package:pokemon_app/modules/home/models/pokemon_details.dart';
import 'package:pokemon_app/modules/home/use_cases/get_pokemon_details_use_case.dart';

part 'pokemon_details_store.g.dart';

class PokemonDetailsStore = PokemonDetailsStoreBase with _$PokemonDetailsStore;

abstract class PokemonDetailsStoreBase with Store {
  final GetPokemonDetailsUseCase _getPokemonDetailsUseCase;

  PokemonDetailsStoreBase({required GetPokemonDetailsUseCase getPokemonDetailsUseCase})
      : _getPokemonDetailsUseCase = getPokemonDetailsUseCase;

  @observable
  bool isLoading = false;

  @observable
  PokemonDetails? pokemonDetails;

  @action
  getPokemonDetails(String name) async {
    isLoading = true;
    try {
      pokemonDetails = await _getPokemonDetailsUseCase.execute(name);
    } catch (e) {
      pokemonDetails = null;
    } finally {
      isLoading = false;
    }
  }
}
