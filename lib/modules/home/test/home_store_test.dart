import 'package:mocktail/mocktail.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nasa_daily_app/modules/home/models/apod_nasa_model.dart';
import 'package:nasa_daily_app/modules/home/repositories/nasa_repository/main.dart';
import 'package:nasa_daily_app/modules/home/stores/home_store.dart';
import 'package:nasa_daily_app/modules/home/use_cases/get_nasa_apod_use_case.dart';

class GetNasaAPODUseCaseContractMock extends Mock implements GetNasaAPODUseCaseContract {}

class NasaRepositoryContractMock extends Mock implements NasaRepositoryContract {}

void main() {
  late Faker faker;

  late NasaRepositoryContractMock nasaRepositoryMock;
  late GetNasaAPODUseCaseContractMock getNasaAPODUseCaseMock;
  late HomeStore store;

  setUp(() {
    faker = Faker();
    nasaRepositoryMock = NasaRepositoryContractMock();
    getNasaAPODUseCaseMock = GetNasaAPODUseCaseContractMock();
    store = HomeStore(getNasaAPODUseCase: getNasaAPODUseCaseMock);
  });

  group("Home Screen Store Unit tests", () {
    test("Should return apodNasaModel as not null when call getAPOD", () async {
      APODNasaModel apodMock = APODNasaModel(
        date: faker.date.dateTime(),
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
  });
}
