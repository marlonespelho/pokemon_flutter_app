import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:nasa_daily_app/generated/l10n.dart';
import 'package:nasa_daily_app/modules/home/stores/apod_favorite_store.dart';
import 'package:nasa_daily_app/modules/home/stores/home_store.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final APODFavoriteStore favoriteStore = Modular.get();
  final HomeStore homeStore = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.favoritePageTitle),
      ),
      body: Observer(builder: (context) {
        if (favoriteStore.loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return favoriteStore.favoriteList.isEmpty
            ? buildEmptyList()
            : buildFavoriteList();
      }),
    );
  }

  buildEmptyList() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 16,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                S.current.favoritePageEmptyList,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: ElevatedButton(
              onPressed: () {
                Modular.to.pop();
              },
              style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                    backgroundColor: WidgetStatePropertyAll(
                      Theme.of(context).colorScheme.secondary,
                    ),
                  ),
              child: Text(
                S.current.backButtonLabel,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildFavoriteList() {
    return ListView.builder(
      itemBuilder: (context, index) {
        final apod = favoriteStore.favoriteList[index];
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () {
              homeStore.getNasaAPOD(date: apod.date);
              Modular.to.pop();
            },
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(
                  imageUrl: apod.url!,
                  width: 60,
                  height: 60,
                  fit: BoxFit.fill,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          value: downloadProgress.progress),
                  errorWidget: (context, url, error) => Icon(
                    Icons.ondemand_video,
                    size: 40,
                  ),
                ),
              ),
              title: Text(apod.title),
              subtitle: Text(DateFormat('dd/MM/yyyy').format(apod.date)),
              trailing: IconButton(
                onPressed: () {
                  favoriteStore.updateAPODFavoriteList(apod);
                },
                icon: Icon(Icons.delete),
              ),
            ),
          ),
        );
      },
      itemCount: favoriteStore.favoriteList.length,
    );
  }
}
