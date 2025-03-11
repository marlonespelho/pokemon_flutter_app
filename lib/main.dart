import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nasa_daily_app/core/config/system.dart';
import 'package:nasa_daily_app/modules/app_core.dart';

Future<void> main() async {
  await System().init();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);
  runApp(const AppCore());
}
