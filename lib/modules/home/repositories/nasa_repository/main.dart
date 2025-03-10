import 'package:nasa_daily_app/core/services/main.dart';
import 'package:nasa_daily_app/modules/home/models/main.dart';

abstract class NasaRepositoryContract {
  final NasaHttpService _httpService;
  NasaRepositoryContract({required NasaHttpService httpService}) : _httpService = httpService;

  Future<APODNasaModel> getAstronomyPictureOfTheDay();
}

class NasaRepository implements NasaRepositoryContract {
  @override
  final NasaHttpService _httpService;
  NasaRepository({required NasaHttpService httpService}) : _httpService = httpService;

  @override
  Future<APODNasaModel> getAstronomyPictureOfTheDay() async {
    var response = await _httpService.get(path: '/planetary/apod');
    return APODNasaModel.fromJson(response);
  }
}

NasaRepositoryContract nasaRepositoryFactory(NasaHttpService httpService) {
  return NasaRepository(httpService: httpService);
}
