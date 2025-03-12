import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nasa_daily_app/core/config/system.dart';
import 'package:nasa_daily_app/modules/app_core.dart';
import 'package:nasa_daily_app/modules/home/views/favorite_page/main.dart';
import 'package:nasa_daily_app/modules/home/views/home_page/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('should open home page and show APODWidget', (WidgetTester tester) async {
    await startApp();
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();
    expect(find.byType(HomePage), findsOneWidget);
    expect(find.byKey(const Key("APODWidget")), findsOneWidget);
  });

  testWidgets('should be add and remove APOD to favorite list', (WidgetTester tester) async {
    await startApp();
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();
    expect(find.byType(HomePage), findsOneWidget);
    expect(find.byKey(const Key("APODWidget")), findsOneWidget);
    await tester.tap(find.byKey(const Key("addFavoriteButton")));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key("removeFavoriteButton")), findsOneWidget);
    await tester.tap(find.byKey(const Key("removeFavoriteButton")));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key("addFavoriteButton")), findsOneWidget);
  });

  testWidgets('should be show Favorite Page with empty List', (WidgetTester tester) async {
    await startApp();
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();
    expect(find.byType(HomePage), findsOneWidget);
    await tester.tap(find.byKey(const Key("favoritePageButton")));
    await tester.pumpAndSettle();
    expect(find.byType(FavoritePage), findsOneWidget);
    expect(find.byKey(const Key("emptyFavoriteList")), findsOneWidget);
  });

  testWidgets('should be show Favorite Page with list', (WidgetTester tester) async {
    await startApp();
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();
    expect(find.byType(HomePage), findsOneWidget);
    expect(find.byKey(const Key("APODWidget")), findsOneWidget);
    await tester.tap(find.byKey(const Key("addFavoriteButton")));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key("favoritePageButton")));
    await tester.pumpAndSettle();
    expect(find.byType(FavoritePage), findsOneWidget);
    expect(find.byKey(const Key("favoriteList")), findsOneWidget);
  });
}

Future<void> startApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({
    'favoriteList': [],
  });
  await System().init();
  runApp(DefaultAssetBundle(bundle: TestAssetBundle(), child: AppCore()));
}

class TestAssetBundle extends CachingAssetBundle {
  @override
  Future<String> loadString(String key, {bool cache = true}) async =>
      utf8.decode((await load(key)).buffer.asUint8List());

  @override
  Future<ByteData> load(String key) async => rootBundle.load(key);
}
