import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemon_app/core/design/theme/theme.dart';
import 'package:pokemon_app/core/services/navigation.dart';
import 'package:pokemon_app/generated/l10n.dart';
import 'package:pokemon_app/modules/app_store.dart';
import 'package:pokemon_app/modules/home/main.dart';
import 'package:sizer/sizer.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final AppStore appStore = Modular.get();

    return Sizer(builder: (context, orientation, deviceType) {
      Modular.setNavigatorKey(GetIt.I.get<NavigationService>().navigatorKey);
      Modular.setInitialRoute(HomeModule.homeRoute);

      return Observer(builder: (context) {
        return MaterialApp.router(
          routeInformationParser: Modular.routeInformationParser,
          routerDelegate: Modular.routerDelegate,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          scrollBehavior: const MaterialScrollBehavior().copyWith(dragDevices: {
            PointerDeviceKind.mouse,
            PointerDeviceKind.touch,
            PointerDeviceKind.stylus,
            PointerDeviceKind.trackpad,
            PointerDeviceKind.unknown
          }),
          debugShowCheckedModeBanner: false,
          supportedLocales: const <Locale>[
            Locale.fromSubtags(languageCode: 'pt', countryCode: 'BR'),
          ],
          theme: DefaultTheme.getTheme(context),
          darkTheme: DarkTheme.getTheme(context),
          themeMode: appStore.themeMode,
        );
      });
    });
  }
}
