import 'package:mobx/mobx.dart';
import 'package:nasa_daily_app/modules/home/models/apod_nasa_model.dart';
import 'package:nasa_daily_app/modules/home/use_cases/main.dart';

part 'apod_favorite_store.g.dart';

class APODFavoriteStore = APODFavoriteStoreBase with _$APODFavoriteStore;

abstract class APODFavoriteStoreBase with Store {
  final GetAPODFavoriteListUseCaseContract _getAPODFavoriteListUseCase;
  final UpdateAPODFavoriteListUseCaseContract _updateAPODFavoriteListUseCase;

  APODFavoriteStoreBase({
    required GetAPODFavoriteListUseCaseContract getAPODFavoriteListUseCase,
    required UpdateAPODFavoriteListUseCaseContract updateAPODFavoriteListUseCase,
  })  : _getAPODFavoriteListUseCase = getAPODFavoriteListUseCase,
        _updateAPODFavoriteListUseCase = updateAPODFavoriteListUseCase {
    init();
  }

  init() {
    getAPODFavoriteList();
  }

  @observable
  List<APODNasaModel> favoriteList = [];

  @observable
  bool loading = false;

  getAPODFavoriteList() async {
    favoriteList = await _getAPODFavoriteListUseCase.execute(null);
  }

  updateAPODFavoriteList(APODNasaModel apod) async {
    loading = true;
    favoriteList = await _updateAPODFavoriteListUseCase.execute(apod);
    setIsFavorite(apod);
    loading = false;
  }

  @observable
  bool isFavorite = false;

  @action
  setIsFavorite(APODNasaModel apod) {
    isFavorite = favoriteList.any((element) => element.date == apod.date);
  }
}
