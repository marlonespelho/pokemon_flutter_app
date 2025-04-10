import 'package:pokemon_app/core/protocols/use_case.dart';
import 'package:pokemon_app/modules/home/models/main.dart';
import 'package:pokemon_app/modules/home/repositories/poke_api_repository/main.dart';

abstract interface class GetPokemonDetailsUseCase implements UseCase<PokemonDetails, String> {}

class DefaultGetPokemonDetailsUseCase implements GetPokemonDetailsUseCase {
  final PokeApiRepositoryContract _repository;

  DefaultGetPokemonDetailsUseCase({required PokeApiRepositoryContract repository}) : _repository = repository;

  @override
  Future<PokemonDetails> execute(String params) async {
    return await _repository.getPokemonDetails(name: params);
  }
}

GetPokemonDetailsUseCase getPokemonDetailsUseCaseFactory(PokeApiRepositoryContract repository) {
  return DefaultGetPokemonDetailsUseCase(repository: repository);
}
