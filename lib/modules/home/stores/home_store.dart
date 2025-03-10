import 'package:mobx/mobx.dart';
import 'package:nasa_daily_app/modules/home/models/apod_nasa_model.dart';
import 'package:nasa_daily_app/modules/home/use_cases/main.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  final GetNasaAPODUseCaseContract _getNasaAPODUseCase;

  HomeStoreBase({required GetNasaAPODUseCaseContract getNasaAPODUseCase}) : _getNasaAPODUseCase = getNasaAPODUseCase;

  @observable
  bool isLoading = false;

  @observable
  APODNasaModel? apodNasaModel;

  getNasaAPOD() async {
    isLoading = true;
    apodNasaModel = await _getNasaAPODUseCase.execute(null);
    isLoading = false;
  }
}
