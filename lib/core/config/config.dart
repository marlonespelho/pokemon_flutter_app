import 'package:nasa_daily_app/core/config/constants.dart';

abstract class BaseConfig {
  String get environmentName;

  String get nasaApiKey;

  String get nasaApiBaseUrl;
}

class ProductionConfig extends BaseConfig {
  @override
  String get environmentName => 'Production';

  @override
  String get nasaApiBaseUrl => String.fromEnvironment(Constants.nasaApiBaseUrl, defaultValue: 'https://api.nasa.gov/');

  @override
  String get nasaApiKey => String.fromEnvironment(Constants.nasaApiKey, defaultValue: '');
}

class StagingConfig extends BaseConfig {
  @override
  String get environmentName => 'Staging';

  @override
  String get nasaApiBaseUrl => String.fromEnvironment(Constants.nasaApiBaseUrl, defaultValue: 'https://api.nasa.gov/');

  @override
  String get nasaApiKey =>
      String.fromEnvironment(Constants.nasaApiKey, defaultValue: 'xTwXRN7mCOoHrHPKSrIanFsmP6EXTUTOZOTrsuam');
}
