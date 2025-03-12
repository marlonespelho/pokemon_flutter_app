import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nasa_daily_app/core/services/main.dart';
import 'package:nasa_daily_app/modules/home/models/apod_nasa_model.dart';
import 'package:nasa_daily_app/modules/home/stores/main.dart';
import 'package:nasa_daily_app/modules/home/use_cases/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigationServiceMock extends Mock implements NavigationService {}

Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  late Faker faker;
  late GetAPODFavoriteListUseCaseContract getAPODFavoriteUseCaseMock;
  late UpdateAPODFavoriteListUseCaseContract updateAPODUseCaseMock;
  late APODFavoriteStore store;

  SharedPreferences.setMockInitialValues({
    'favoriteList': [],
  });
  SharedPreferences prefs = await SharedPreferences.getInstance();

  setUp(() {
    faker = Faker();
    getAPODFavoriteUseCaseMock = getAPODFavoriteListUseCaseFactory(prefs);
    updateAPODUseCaseMock = updateAPODFavoriteListUseCaseFactory(prefs);

    store = APODFavoriteStore(
      getAPODFavoriteListUseCase: getAPODFavoriteUseCaseMock,
      updateAPODFavoriteListUseCase: updateAPODUseCaseMock,
    );
  });

  group("APOD Favorite Store Unit tests", () {
    test("getAPODFavoriteList should be return list of favorite apod",
        () async {
      APODNasaModel apodMock = APODNasaModel(
        date: DateTime.now(),
        explanation: faker.lorem.sentence(),
        hdurl: faker.internet.httpsUrl(),
        mediaType: faker.lorem.word(),
        serviceVersion: faker.lorem.word(),
        title: faker.lorem.word(),
        url: faker.internet.httpsUrl(),
      );

      List<APODNasaModel> favoriteList = [apodMock];

      prefs.setStringList('favoriteList',
          favoriteList.map((e) => jsonEncode(e.toJson())).toList());

      await store.getAPODFavoriteList();
      assert(store.favoriteList.length == 1);
    });

    test("getAPODFavoriteList should be return empty list of favorite apod",
        () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('favoriteList', []);

      await store.getAPODFavoriteList();
      assert(store.favoriteList.isEmpty);
    });

    test("updateAPODFavoriteList should be add item in list of favorite apod",
        () async {
      List<APODNasaModel> favoriteList = [];
      await prefs.setStringList('favoriteList',
          favoriteList.map((e) => e.toJson().toString()).toList());

      assert(store.favoriteList.isEmpty);

      APODNasaModel apodMock = APODNasaModel(
        date: DateTime.now(),
        explanation: faker.lorem.sentence(),
        hdurl: faker.internet.httpsUrl(),
        mediaType: faker.lorem.word(),
        serviceVersion: faker.lorem.word(),
        title: faker.lorem.word(),
        url: faker.internet.httpsUrl(),
      );

      await store.updateAPODFavoriteList(apodMock);
      assert(store.favoriteList.length == 1);
    });

    test(
        "updateAPODFavoriteList should be remove item in list of favorite apod",
        () async {
      APODNasaModel apodMock = APODNasaModel(
        date: DateTime.now(),
        explanation: faker.lorem.sentence(),
        hdurl: faker.internet.httpsUrl(),
        mediaType: faker.lorem.word(),
        serviceVersion: faker.lorem.word(),
        title: faker.lorem.word(),
        url: faker.internet.httpsUrl(),
      );

      List<APODNasaModel> favoriteList = [apodMock];

      await prefs.setStringList('favoriteList',
          favoriteList.map((e) => jsonEncode(e.toJson())).toList());

      assert(store.favoriteList.length == 1);

      await store.updateAPODFavoriteList(apodMock);

      assert(store.favoriteList.isEmpty);
    });

    test("isFavorite should be return true when apod is in favorite list",
        () async {
      APODNasaModel apodMock = APODNasaModel(
        date: DateTime.now(),
        explanation: faker.lorem.sentence(),
        hdurl: faker.internet.httpsUrl(),
        mediaType: faker.lorem.word(),
        serviceVersion: faker.lorem.word(),
        title: faker.lorem.word(),
        url: faker.internet.httpsUrl(),
      );

      List<APODNasaModel> favoriteList = [apodMock];

      await prefs.setStringList('favoriteList',
          favoriteList.map((e) => jsonEncode(e.toJson())).toList());
      await store.getAPODFavoriteList();
      store.setIsFavorite(apodMock);
      assert(store.isFavorite);
    });

    test("isFavorite should be return false when apod isn't in favorite list",
        () async {
      APODNasaModel apodMock = APODNasaModel(
        date: DateTime.now(),
        explanation: faker.lorem.sentence(),
        hdurl: faker.internet.httpsUrl(),
        mediaType: faker.lorem.word(),
        serviceVersion: faker.lorem.word(),
        title: faker.lorem.word(),
        url: faker.internet.httpsUrl(),
      );

      await prefs.setStringList('favoriteList', []);
      await store.getAPODFavoriteList();
      store.setIsFavorite(apodMock);
      assert(!store.isFavorite);
    });
  });
}
