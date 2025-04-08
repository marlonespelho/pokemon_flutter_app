import 'package:pokemon_app/core/config/constants.dart';

abstract class BaseConfig {
  String get environmentName;

  String get pokeApiBaseUrl;
}

class ProductionConfig extends BaseConfig {
  @override
  String get environmentName => 'Production';

  @override
  String get pokeApiBaseUrl => String.fromEnvironment(Constants.pokeApiBaseUrl, defaultValue: 'https://pokeapi.co/api/');
}

class StagingConfig extends BaseConfig {
  @override
  String get environmentName => 'Staging';

  @override
  String get pokeApiBaseUrl => String.fromEnvironment(Constants.pokeApiBaseUrl, defaultValue: 'https://pokeapi.co/api/');

}
