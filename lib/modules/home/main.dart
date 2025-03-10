import 'package:flutter_modular/flutter_modular.dart';
import 'package:nasa_daily_app/modules/home/views/home_page/main.dart';

class HomeModule extends Module {
  static const String homeRoute = "/home";

  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute("/", child: (_, args) => const HomePage()),
      ];
}
