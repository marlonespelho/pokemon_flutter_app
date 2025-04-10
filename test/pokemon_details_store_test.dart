import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon_app/core/models/main.dart';
import 'package:pokemon_app/core/services/main.dart';
import 'package:pokemon_app/modules/home/models/main.dart';
import 'package:pokemon_app/modules/home/stores/pokemon_details_store.dart';
import 'package:pokemon_app/modules/home/use_cases/get_pokemon_details_use_case.dart';

class GetPokemonDetailsUseCaseMock extends Mock implements GetPokemonDetailsUseCase {}

class PaginateMock extends Mock implements Paginate {}

class NavigationServiceMock extends Mock implements NavigationService {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late Faker faker;
  late GetPokemonDetailsUseCase getPokemonDetailsUseCaseMock;
  late PokemonDetailsStore store;

  setUp(() {
    faker = Faker();
    getPokemonDetailsUseCaseMock = GetPokemonDetailsUseCaseMock();
    store = PokemonDetailsStore(getPokemonDetailsUseCase: getPokemonDetailsUseCaseMock);
    setupDependencyInjection();
  });

  setUpAll(() {
    registerFallbackValue(PaginateMock());
  });

  group("Pokemon Details Store Unit tests", () {
    test("Should return a PokemonDetails object when getPokemonDetails is called", () async {
      final String name = faker.lorem.word();
      final PokemonDetails pokemonDetails = PokemonDetails(
        id: 1,
        name: name,
        height: 1,
        weight: 1,
        baseExperience: 1,
        abilities: [],
        stats: [],
        sprites: Sprites(frontDefault: '', officialArtwork: ''),
        types: [],
      );

      when(() => getPokemonDetailsUseCaseMock.execute(name)).thenAnswer((_) async => pokemonDetails);

      await store.getPokemonDetails(name);

      expect(store.pokemonDetails, isA<PokemonDetails>());
      expect(store.pokemonDetails?.name, name);
    });

    test("Should return null object when getPokemonDetails throw an exception", () async {
      final String name = faker.lorem.word();
      when(() => getPokemonDetailsUseCaseMock.execute(name)).thenThrow(Exception("Error"));
      await store.getPokemonDetails(name);
      expect(store.pokemonDetails, isNull);
      expect(store.isLoading, false);
    });
  });
}

void setupDependencyInjection() {
  final NavigationServiceMock navigationServiceMock = NavigationServiceMock();
  when(() => navigationServiceMock.navigatorKey).thenReturn(GlobalKey<NavigatorState>());
  if (GetIt.instance.isRegistered<NavigationService>()) {
    GetIt.instance.unregister<NavigationService>();
  }
  GetIt.instance.registerSingleton<NavigationService>(navigationServiceMock);
}
