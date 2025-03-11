
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:mobx/mobx.dart';
import 'package:nasa_daily_app/modules/home/models/main.dart';
import 'package:video_player/video_player.dart';

class ApodVideoWidget extends StatefulWidget {
  final APODNasaModel apodNasa;

  const ApodVideoWidget({super.key, required this.apodNasa});

  @override
  State<ApodVideoWidget> createState() => _ApodVideoWidgetState();
}

class _ApodVideoWidgetState extends State<ApodVideoWidget> {
  late VideoPlayerController controller;

  Observable<bool> videoPlayerError = Observable(false);


  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.networkUrl(
      Uri.parse(
        widget.apodNasa.url ?? "",
      ),
    )..initialize().then((_) {
      setState(() {});
    }).onError((error, stackTrace) {
      runInAction(() {
        videoPlayerError.value = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      if (videoPlayerError.value) {
        return HtmlWidget(
          "<iframe src='${widget.apodNasa.url}' "
              "width='100%' height='100%' frameborder='0' allow='autoplay; "
              "encrypted-media' allowfullscreen>"
              "</iframe>",
          baseUrl: Uri.parse(widget.apodNasa.url!),
        );
      }

      return controller.value.isInitialized
          ? AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: VideoPlayer(controller),
      )
          : SizedBox();
    });
  }
}
