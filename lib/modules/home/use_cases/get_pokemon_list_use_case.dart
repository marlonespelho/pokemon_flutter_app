import 'package:pokemon_app/core/models/paginate.dart';
import 'package:pokemon_app/core/protocols/use_case.dart';
import 'package:pokemon_app/modules/home/repositories/poke_api_repository/main.dart';

abstract interface class GetPokemonListUseCase implements UseCase<Paginate, Paginate> {}

class DefaultGetPokemonListUseCase implements GetPokemonListUseCase {
  final PokeApiRepositoryContract _repository;
  DefaultGetPokemonListUseCase({required PokeApiRepositoryContract repository}) : _repository = repository;

  @override
  Future<Paginate> execute(Paginate params) async {
    return await _repository.getPokemonList(
      limit: params.limit,
    );
  }
}