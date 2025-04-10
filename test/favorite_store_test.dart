import 'dart:convert';

import 'package:mocktail/mocktail.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon_app/core/services/main.dart';
import 'package:pokemon_app/modules/favorite/stores/favorite_store.dart';
import 'package:pokemon_app/modules/favorite/use_cases/main.dart';
import 'package:pokemon_app/modules/home/models/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigationServiceMock extends Mock implements NavigationService {}

Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  late Faker faker;
  late GetFavoriteListUseCaseContract getFavoriteUseCaseMock;
  late UpdateFavoriteListUseCaseContract updateUseCaseMock;
  late FavoriteStore store;

  SharedPreferences.setMockInitialValues({
    'favoriteList': [],
  });
  SharedPreferences prefs = await SharedPreferences.getInstance();

  setUp(() {
    faker = Faker();
    getFavoriteUseCaseMock = getFavoriteListUseCaseFactory(prefs);
    updateUseCaseMock = updateFavoriteListUseCaseFactory(prefs);

    store = FavoriteStore(
      getFavoriteListUseCase: getFavoriteUseCaseMock,
      updateFavoriteListUseCase: updateUseCaseMock,
    );
  });

  group("Favorite Store Unit tests", () {
    test("getFavoriteList should be return list of favorite pokemons", () async {
      Pokemon pokemonMock = Pokemon(
        id: faker.randomGenerator.integer(100),
        name: faker.lorem.word(),
        url: "https://pokeapi.co/api/v2/pokemon/1/",
      );

      List<Pokemon> favoriteList = [pokemonMock];

      prefs.setStringList('favoriteList', favoriteList.map((e) => jsonEncode(e.toJson())).toList());

      await store.getFavoriteList();
      assert(store.favoriteList.length == 1);
    });

    test("getFavoriteList should be return empty list of favorite pokemons", () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('favoriteList', []);

      await store.getFavoriteList();
      assert(store.favoriteList.isEmpty);
    });

    test("updateFavoriteList should be add item in list of favorite pokemons", () async {
      List<Pokemon> favoriteList = [];
      await prefs.setStringList('favoriteList', favoriteList.map((e) => e.toJson().toString()).toList());

      assert(store.favoriteList.isEmpty);

      Pokemon pokemonMock = Pokemon(
        id: faker.randomGenerator.integer(100),
        name: faker.lorem.word(),
        url: "https://pokeapi.co/api/v2/pokemon/1/",
      );

      await store.updateFavoriteList(pokemonMock);
      assert(store.favoriteList.length == 1);
    });

    test("updateFavoriteList should be remove item in list of favorite pokemon", () async {
      Pokemon pokemonMock = Pokemon(
        id: faker.randomGenerator.integer(100),
        name: faker.lorem.word(),
        url: "https://pokeapi.co/api/v2/pokemon/1/",
      );

      List<Pokemon> favoriteList = [pokemonMock];

      await prefs.setStringList('favoriteList', favoriteList.map((e) => jsonEncode(e.toJson())).toList());

      assert(store.favoriteList.length == 1);

      await store.updateFavoriteList(pokemonMock);

      assert(store.favoriteList.isEmpty);
    });

    test("isFavorite should be return true when pokemon is in favorite list", () async {
      Pokemon pokemonMock = Pokemon(
        id: faker.randomGenerator.integer(100),
        name: faker.lorem.word(),
        url: "https://pokeapi.co/api/v2/pokemon/1/",
      );

      List<Pokemon> favoriteList = [pokemonMock];

      await prefs.setStringList('favoriteList', favoriteList.map((e) => jsonEncode(e.toJson())).toList());
      await store.getFavoriteList();
      bool isFavorite = store.isFavorite(pokemonMock);
      assert(isFavorite == true);
    });

    test("isFavorite should be return false when apod isn't in favorite list", () async {
      Pokemon pokemonMock = Pokemon(
        id: faker.randomGenerator.integer(100),
        name: faker.lorem.word(),
        url: "https://pokeapi.co/api/v2/pokemon/1/",
      );

      await prefs.setStringList('favoriteList', []);
      await store.getFavoriteList();
      bool isFavorite = store.isFavorite(pokemonMock);
      assert(isFavorite == false);
    });
  });
}
