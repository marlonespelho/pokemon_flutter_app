import 'package:flutter_modular/flutter_modular.dart';
import 'package:nasa_daily_app/core/config/environment.dart';
import 'package:nasa_daily_app/core/services/nasa_api_service.dart';
import 'package:nasa_daily_app/modules/app_store.dart';
import 'package:nasa_daily_app/modules/home/main.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) =>
            NasaHttpService(baseUrl: Environment().config.nasaApiBaseUrl)),
        Bind((i) => AppStore()),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(HomeModule.homeRoute, module: HomeModule()),
      ];
}
