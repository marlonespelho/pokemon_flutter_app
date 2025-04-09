import 'package:pokemon_app/core/models/main.dart';
import 'package:pokemon_app/core/services/main.dart';
import 'package:pokemon_app/modules/home/models/pokemon.dart';

abstract class PokeApiRepositoryContract {
  final PokeAPIHttpService _httpService;

  PokeApiRepositoryContract({required PokeAPIHttpService httpService}) : _httpService = httpService;

  Future<Paginate> getPokemonList({int limit = 20});

  Future<Paginate> getPokemonListNextPage({required Paginate paginate});
}

class DefaultPokeAPIRepository implements PokeApiRepositoryContract {
  @override
  final PokeAPIHttpService _httpService;

  DefaultPokeAPIRepository({required PokeAPIHttpService httpService}) : _httpService = httpService;

  @override
  Future<Paginate> getPokemonList({int limit = 20}) async {
    var response = await _httpService.get(path: '/v2/pokemon', queryParams: {
      'limit': limit,
    });

    List<Pokemon> data = response['results'].map<Pokemon>((json) => Pokemon.fromJson(json)).toList();
    return Paginate.fromJson(response, data: data);
  }

  @override
  Future<Paginate> getPokemonListNextPage({required Paginate paginate}) async {
    var response = await _httpService.get(
      path: paginate.nextPage!,
      queryParams: {
        'limit': paginate.limit,
      },
    );

    List<Pokemon> data = [
      ...(paginate.data as List<Pokemon>),
      ...response['results'].map<Pokemon>((json) => Pokemon.fromJson(json)).toList()
    ];

    return Paginate.fromJson(response, data: data);
  }
}

PokeApiRepositoryContract pokeAPIRepositoryFactory(PokeAPIHttpService httpService) {
  return DefaultPokeAPIRepository(httpService: httpService);
}
