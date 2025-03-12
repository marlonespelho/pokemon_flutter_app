import 'package:intl/intl.dart';
import 'package:nasa_daily_app/core/services/main.dart';
import 'package:nasa_daily_app/modules/home/models/main.dart';

abstract class NasaRepositoryContract {
  final NasaHttpService _httpService;

  NasaRepositoryContract({required NasaHttpService httpService}) : _httpService = httpService;

  Future<APODNasaModel> getAstronomyPictureOfTheDay({DateTime? date});
}

class NasaRepository implements NasaRepositoryContract {
  @override
  final NasaHttpService _httpService;

  NasaRepository({required NasaHttpService httpService}) : _httpService = httpService;

  @override
  Future<APODNasaModel> getAstronomyPictureOfTheDay({DateTime? date}) async {
    var response = await _httpService.get(path: '/planetary/apod', queryParams: {
      if (date != null) 'date': DateFormat('yyyy-MM-dd').format(date),
    });
    return APODNasaModel.fromJson(response);
  }
}

NasaRepositoryContract nasaRepositoryFactory(NasaHttpService httpService) {
  return NasaRepository(httpService: httpService);
}
