import 'package:flutter_modular/flutter_modular.dart';
import 'package:nasa_daily_app/modules/home/main.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(HomeModule.homeRoute, module: HomeModule()),
      ];
}
