import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:nasa_daily_app/generated/l10n.dart';
import 'package:nasa_daily_app/modules/home/models/main.dart';
import 'package:nasa_daily_app/modules/home/stores/home_store.dart';
import 'package:nasa_daily_app/modules/home/views/home_page/apod_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeStore homeStore = Modular.get();

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
        body: buildContent());
  }

  buildSearchDateButton() {
    return FloatingActionButton(
      onPressed: () {
        showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1995, 06, 16),
          lastDate: DateTime.now(),
        ).then((value) {
          if (value != null) {
            homeStore.getNasaAPOD();
          }
        });
      },
      child: Icon(Icons.calendar_today),
    );
  }

  Observer buildContent() {
    return Observer(builder: (context) {
      return homeStore.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : homeStore.apodNasa != null
              ? SingleChildScrollView(
                  child: NasaApodWidget(
                    apodNasa: homeStore.apodNasa!,
                    onHdPressed: homeStore.changeShowHD,
                    addFavorite: (APODNasaModel apod) {},
                    showHd: homeStore.showHD,
                    isFavorite: false,
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
