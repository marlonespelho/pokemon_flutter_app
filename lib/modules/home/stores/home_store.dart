import 'package:mobx/mobx.dart';
import 'package:nasa_daily_app/core/design/widgets/error_widget.dart';
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
  bool showHD = false;

  @observable
  APODNasaModel? apodNasa;

  changeShowHD() {
    showHD = !showHD;
  }

  getNasaAPOD() async {
    try {
      isLoading = true;
      apodNasa = await _getNasaAPODUseCase.execute(null);
    } catch (e) {
      handleException(e);
    } finally {
      isLoading = false;
    }
  }
}
