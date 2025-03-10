import 'package:nasa_daily_app/core/http/http_service.dart';
import 'package:nasa_daily_app/modules/home/models/main.dart';

abstract class NasaRepositoryContract {
  final HttpService _httpService;
  NasaRepositoryContract({required HttpService httpService}) : _httpService = httpService;

  Future<APODNasaModel> getAstronomyPictureOfTheDay();
}

class NasaRepository implements NasaRepositoryContract {
  @override
  final HttpService _httpService;
  NasaRepository({required HttpService httpService}) : _httpService = httpService;

  @override
  Future<APODNasaModel> getAstronomyPictureOfTheDay() async {
    var response = await _httpService.get(path: '/planetary/apod');
    return APODNasaModel.fromJson(response);
  }
}
