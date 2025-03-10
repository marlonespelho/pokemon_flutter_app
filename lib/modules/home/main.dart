import 'package:flutter_modular/flutter_modular.dart';
import 'package:nasa_daily_app/modules/home/repositories/nasa_repository/main.dart';
import 'package:nasa_daily_app/modules/home/stores/home_store.dart';
import 'package:nasa_daily_app/modules/home/use_cases/get_nasa_apod_use_case.dart';
import 'package:nasa_daily_app/modules/home/views/home_page/main.dart';

class HomeModule extends Module {
  static const String homeRoute = "/home";

  @override
  List<Bind> get binds => [
        Bind((i) => nasaRepositoryFactory(i.get())),
        Bind((i) => getNasaAPODUseCaseFactory(i.get())),
        Bind((i) => HomeStore(getNasaAPODUseCase: i.get())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute("/", child: (_, args) => const HomePage()),
      ];
}
