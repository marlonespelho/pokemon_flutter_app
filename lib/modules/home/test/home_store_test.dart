import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nasa_daily_app/core/services/main.dart';
import 'package:nasa_daily_app/modules/home/models/apod_nasa_model.dart';
import 'package:nasa_daily_app/modules/home/repositories/nasa_repository/main.dart';
import 'package:nasa_daily_app/modules/home/stores/home_store.dart';
import 'package:nasa_daily_app/modules/home/use_cases/get_nasa_apod_use_case.dart';

class GetNasaAPODUseCaseContractMock extends Mock implements GetNasaAPODUseCaseContract {}

class NasaRepositoryContractMock extends Mock implements NasaRepositoryContract {}

class NavigationServiceMock extends Mock implements NavigationService {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late Faker faker;
  late GetNasaAPODUseCaseContractMock getNasaAPODUseCaseMock;
  late HomeStore store;
  setUp(() {
    faker = Faker();
    getNasaAPODUseCaseMock = GetNasaAPODUseCaseContractMock();
    store = HomeStore(getNasaAPODUseCase: getNasaAPODUseCaseMock);
    setupDependencyInjection();
  });

  group("Home Screen Store Unit tests", () {
    test("Should return apodNasaModel as not null when call getAPOD", () async {
      APODNasaModel apodMock = APODNasaModel(
        date: DateTime.now(),
        explanation: faker.lorem.sentence(),
        hdurl: faker.internet.httpsUrl(),
        mediaType: faker.lorem.word(),
        serviceVersion: faker.lorem.word(),
        title: faker.lorem.word(),
        url: faker.internet.httpsUrl(),
      );
      when(() => getNasaAPODUseCaseMock.execute(null)).thenAnswer((_) async => apodMock);
      await store.getNasaAPOD();
      expect(store.apodNasa, apodMock);
    });

    test("Should return apodNasa as not null when call getAPOD with Date", () async {
      DateTime date = faker.date.dateTime();
      APODNasaModel apodMock = APODNasaModel(
        date: date,
        explanation: faker.lorem.sentence(),
        hdurl: faker.internet.httpsUrl(),
        mediaType: faker.lorem.word(),
        serviceVersion: faker.lorem.word(),
        title: faker.lorem.word(),
        url: faker.internet.httpsUrl(),
      );
      when(() => getNasaAPODUseCaseMock.execute(date)).thenAnswer((_) async => apodMock);
      await store.getNasaAPOD(date: date);
      expect(store.apodNasa, apodMock);
    });

    test("getNasaAPODUseCaseMock should return null when receive exception", () async {
      when(() => getNasaAPODUseCaseMock.execute(null)).thenThrow(Exception());
      await store.getNasaAPOD();
      expect(store.apodNasa, null);
    });
  });
}

void setupDependencyInjection() {
  final NavigationServiceMock navigationServiceMock = NavigationServiceMock();
  when(() => navigationServiceMock.navigatorKey).thenReturn(GlobalKey<NavigatorState>());
  if(GetIt.instance.isRegistered<NavigationService>()) {
    GetIt.instance.unregister<NavigationService>();
  }
  GetIt.instance.registerSingleton<NavigationService>(navigationServiceMock);
}
