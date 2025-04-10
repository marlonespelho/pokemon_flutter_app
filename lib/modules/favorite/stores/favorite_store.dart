import 'package:mobx/mobx.dart';
import 'package:pokemon_app/modules/favorite/use_cases/main.dart';
import 'package:pokemon_app/modules/home/models/main.dart';

part 'favorite_store.g.dart';

class FavoriteStore = FavoriteStoreBase with _$FavoriteStore;

abstract class FavoriteStoreBase with Store {
  final GetFavoriteListUseCaseContract _getFavoriteListUseCase;
  final UpdateFavoriteListUseCaseContract _updateFavoriteListUseCase;

  FavoriteStoreBase({
    required GetFavoriteListUseCaseContract getFavoriteListUseCase,
    required UpdateFavoriteListUseCaseContract updateFavoriteListUseCase,
  })  : _getFavoriteListUseCase = getFavoriteListUseCase,
        _updateFavoriteListUseCase = updateFavoriteListUseCase {
    init();
  }

  init() {
    getFavoriteList();
  }

  @observable
  List<Pokemon> favoriteList = [];

  @observable
  bool loading = false;

  getFavoriteList() async {
    favoriteList = await _getFavoriteListUseCase.execute(null);
  }

  updateFavoriteList(Pokemon pokemon, {Function? callback}) async {
    loading = true;
    favoriteList = await _updateFavoriteListUseCase.execute(pokemon);
    loading = false;
    callback?.call(isFavorite(pokemon));
  }

  @action
  isFavorite(Pokemon pokemon) {
    return favoriteList.any((element) => element.name == pokemon.name);
  }
}
