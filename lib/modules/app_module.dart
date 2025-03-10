import 'package:flutter_modular/flutter_modular.dart';
import 'package:nasa_daily_app/core/config/environment.dart';
import 'package:nasa_daily_app/core/http/dio/dio_http_service.dart';
import 'package:nasa_daily_app/modules/home/main.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => DioHttpService(baseUrl: Environment().config.nasaApiBaseUrl)),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(HomeModule.homeRoute, module: HomeModule()),
      ];
}
