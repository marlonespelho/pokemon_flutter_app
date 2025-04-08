import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon_app/core/models/main.dart';
import 'package:pokemon_app/core/services/main.dart';
import 'package:pokemon_app/modules/home/stores/main.dart';
import 'package:pokemon_app/modules/home/use_cases/get_pokemon_list_use_case.dart';

class GetPokemonListUseCaseMock  extends Mock implements GetPokemonListUseCase {}

class PaginateMock extends Mock implements Paginate {}

class NavigationServiceMock extends Mock implements NavigationService {}

void main() {

  TestWidgetsFlutterBinding.ensureInitialized();
  late Faker faker;
  late GetPokemonListUseCaseMock getPokemonListUseCaseMock;
  late HomeStore store;

  setUp(() {
    faker = Faker();
    getPokemonListUseCaseMock = GetPokemonListUseCaseMock();
    store = HomeStore(getPokemonListUseCase: getPokemonListUseCaseMock);
    setupDependencyInjection();
  });

  setUpAll(() {
    registerFallbackValue(PaginateMock());
  });

  group("Home Screen Store Unit tests", () {
    test("Should return pokemon paginate list when call getPokemonList", () async {
      Paginate paginateMock = Paginate(
        count: 20,
        nextPage: faker.internet.httpsUrl(),
        previousPage: faker.internet.httpsUrl(),
        data: [],
      );
      when(() => getPokemonListUseCaseMock.execute(any())).thenAnswer((_) async => paginateMock);
      await store.getPokemonList();
      expect(store.paginate, paginateMock);
    });

    test("Should return pokemon paginate empty list when call getPokemonList", () async {
      Paginate paginateMock = Paginate(
        count: 0,
        nextPage: null,
        previousPage: null,
        data: [],
      );
      when(() => getPokemonListUseCaseMock.execute(any())).thenAnswer((_) async => paginateMock);
      await store.getPokemonList();
      expect(store.paginate, paginateMock);
    });


    test("Should return exception when call getPokemonList", () async {
      when(() => getPokemonListUseCaseMock.execute(any())).thenThrow(Exception("Error"));
      await store.getPokemonList();
      expect(store.paginate, null);
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
