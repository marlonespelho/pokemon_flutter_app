import 'package:mobx/mobx.dart';
import 'package:pokemon_app/core/models/main.dart';
import 'package:pokemon_app/modules/home/models/main.dart';
import 'package:pokemon_app/modules/home/use_cases/get_pokemon_list_use_case.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  final GetPokemonListUseCase _getPokemonListUseCase;

  HomeStoreBase({required GetPokemonListUseCase getPokemonListUseCase})
      : _getPokemonListUseCase = getPokemonListUseCase;

  @observable
  bool isLoading = false;

  @observable
  Paginate? paginate;

  @computed
  List<Pokemon>? get pokemonList => paginate?.data as List<Pokemon>?;

  @action
  getPokemonList() async {
    isLoading = true;
    try {
      paginate = await _getPokemonListUseCase.execute(Paginate(limit: 20));
    } catch (e) {
      paginate = null;
    } finally {
      isLoading = false;
    }
  }
}
