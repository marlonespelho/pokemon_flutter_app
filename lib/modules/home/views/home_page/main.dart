import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:nasa_daily_app/generated/l10n.dart';
import 'package:nasa_daily_app/modules/home/models/main.dart';
import 'package:nasa_daily_app/modules/home/stores/apod_favorite_store.dart';
import 'package:nasa_daily_app/modules/home/stores/home_store.dart';
import 'package:nasa_daily_app/modules/home/views/home_page/apod_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeStore homeStore = Modular.get();
  final APODFavoriteStore favoriteStore = Modular.get();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      homeStore.getNasaAPOD();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.homeAppBarTitle),
        actions: [],
      ),
      floatingActionButton: buildSearchDateButton(),
      body: buildContent(),
    );
  }

  buildSearchDateButton() {
    return FloatingActionButton(
      onPressed: () {
        showDatePicker(
          context: context,
          initialDate: homeStore.searchDate,
          currentDate: homeStore.searchDate,
          firstDate: DateTime(1995, 06, 16),
          lastDate: DateTime.now(),
        ).then((value) {
          if (value != null) {
            homeStore.searchDate = value;
            homeStore.getNasaAPOD(date: value);
          }
        });
      },
      child: Icon(Icons.calendar_today),
    );
  }

  Observer buildContent() {
    return Observer(builder: (context) {
      if(homeStore.apodNasa != null) {
        favoriteStore.setIsFavorite(homeStore.apodNasa!);
      }
      return homeStore.isLoading
          ? Container(
              height: MediaQuery.of(context).size.height,
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
          : homeStore.apodNasa != null
              ? SingleChildScrollView(
                  child: NasaApodWidget(
                    apodNasa: homeStore.apodNasa!,
                    onHdPressed: homeStore.changeShowHD,
                    addFavorite: (APODNasaModel apod) async {
                      await favoriteStore.updateAPODFavoriteList(apod);
                    },
                    showHd: homeStore.showHD,
                    isFavorite: favoriteStore.isFavorite,
                  ),
                )
              : buildError();
    });
  }

  Center buildError() {
    return Center(
      child: Text(S.current.nasaApodError),
    );
  }
}
