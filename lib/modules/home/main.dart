import 'package:flutter_modular/flutter_modular.dart';
import 'package:pokemon_app/modules/home/stores/home_store.dart';
import 'package:pokemon_app/modules/home/views/home_page/main.dart';

class HomeModule extends Module {
  static const String homeRoute = "/home";
  static const String favoriteRoute = "/home/favorite";

  @override
  List<Bind> get binds => [
        Bind(
          (i) => HomeStore(),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute("/", child: (_, args) => const HomePage()),
      ];
}
