import 'package:pokemon_app/core/services/main.dart';

abstract class PokeApiRepositoryContract {
  final PokeAPIHttpService _httpService;

  PokeApiRepositoryContract({required PokeAPIHttpService httpService}) : _httpService = httpService;

}

class DefaultPokeAPIRepository implements PokeApiRepositoryContract {
  @override
  final PokeAPIHttpService _httpService;

  DefaultPokeAPIRepository({required PokeAPIHttpService httpService}) : _httpService = httpService;

}

PokeApiRepositoryContract pokeAPIRepositoryFactory(PokeAPIHttpService httpService) {
  return DefaultPokeAPIRepository(httpService: httpService);
}
