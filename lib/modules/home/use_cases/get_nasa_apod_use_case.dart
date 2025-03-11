import 'package:nasa_daily_app/core/protocols/use_case.dart';
import 'package:nasa_daily_app/modules/home/models/apod_nasa_model.dart';
import 'package:nasa_daily_app/modules/home/repositories/nasa_repository/main.dart';

abstract interface class GetNasaAPODUseCaseContract implements UseCase<APODNasaModel, DateTime?> {}

class GetNasaAPODUseCase implements GetNasaAPODUseCaseContract {
  final NasaRepositoryContract _nasaRepository;

  GetNasaAPODUseCase(this._nasaRepository);

  @override
  Future<APODNasaModel> execute(DateTime? param) async {
    return await _nasaRepository.getAstronomyPictureOfTheDay(date: param);
  }
}

GetNasaAPODUseCaseContract getNasaAPODUseCaseFactory(NasaRepositoryContract nasaRepository) {
  return GetNasaAPODUseCase(nasaRepository);
}
