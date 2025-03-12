import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nasa_daily_app/core/design/theme/palette.dart';
import 'package:nasa_daily_app/generated/l10n.dart';
import 'package:nasa_daily_app/modules/home/models/apod_nasa_model.dart';
import 'package:nasa_daily_app/modules/home/views/home_page/apod_video_widget.dart';

class NasaApodWidget extends StatelessWidget {
  final APODNasaModel apodNasa;
  final Function onHdPressed;
  final bool showHd;
  final bool isFavorite;
  final Function(APODNasaModel apod) addFavorite;

  const NasaApodWidget({
    super.key,
    required this.apodNasa,
    required this.onHdPressed,
    required this.addFavorite,
    required this.showHd,
    required this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      key: Key("APODWidget"),
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return buildPortraitContent(context);
        } else {
          return buildLandsCapeContent(context);
        }
      },
    );
  }

  buildPortraitContent(BuildContext context) {
    return Column(
      children: [
        buildContent(context),
        buildTitle(context),
        buildExplanation(context),
      ],
    );
  }

  buildLandsCapeContent(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 6,
          child: buildContent(context),
        ),
        Flexible(
          flex: 4,
          child: Column(
            children: [
              buildTitle(context),
              buildExplanation(context),
            ],
          ),
        ),
      ],
    );
  }

  buildContent(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        apodNasa.mediaType == 'video' ? ApodVideoWidget(apodNasa: apodNasa) : buildImage(context),
        Align(
          alignment: Alignment.bottomRight,
          child: Container(
            width: apodNasa.mediaType == 'image' ? 96 : 48,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (apodNasa.mediaType == 'image') buildHdButton(context),
                buildFavoriteButton(context),
              ],
            ),
          ),
        ),
      ],
    );
  }

  IconButton buildFavoriteButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        addFavorite(apodNasa);
      },
      icon: Icon(
        key: isFavorite ? Key("removeFavoriteButton") : Key("addFavoriteButton"),
        isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
        color: isFavorite ? Colors.red : Theme.of(context).colorScheme.primary,
      ),
    );
  }

  IconButton buildHdButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        onHdPressed();
      },
      iconSize: 32,
      icon: Icon(
        showHd ? Icons.hd_outlined : Icons.sd_outlined,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Widget buildImage(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return InkWell(
        onTap: () {
          showImageViewer(
            context,
            CachedNetworkImageProvider(
              showHd ? apodNasa.hdurl ?? "" : apodNasa.url ?? "",
            ),
            useSafeArea: true,
            swipeDismissible: true,
            doubleTapZoomable: true,
          );
        },
        child: CachedNetworkImage(
          imageUrl: showHd ? apodNasa.hdurl ?? "" : apodNasa.url ?? "",
          width: MediaQuery.of(context).size.width * (constraints.maxWidth < 600 ? 1 : 0.6),
          progressIndicatorBuilder: (context, url, downloadProgress) => Center(
            child: CircularProgressIndicator(value: downloadProgress.progress),
          ),
          errorWidget: (context, url, error) => Container(
            color: Palette.onSecondaryColor.withValues(alpha: 0.2),
            padding: EdgeInsets.symmetric(vertical: 64),
            child: Column(
              spacing: 16,
              children: [
                Icon(
                  Icons.broken_image_outlined,
                  color: Palette.primary,
                  size: 60,
                ),
                Text(
                  S.current.imageCouldNotBeLoaded,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget buildTitle(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            apodNasa.title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            DateFormat("dd/MM/yyyy").format(apodNasa.date),
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget buildExplanation(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        apodNasa.explanation,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
