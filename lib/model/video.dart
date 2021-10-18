import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:standup_india/util/navigator.dart';

class Video {
  late String title;
  late String url;
  late String thumbnail;
  late String comic;

  // Video({required this.title, required this.thumbnail, required this.url, required this.comic});

  factory Video(Map jsonMap) => Video._internalFromJson(jsonMap);

  Video._internalFromJson(Map jsonMap)
      : url = jsonMap['url'],
        comic = jsonMap['comic'],
        title = jsonMap['title'],
        thumbnail = jsonMap['thumbnail'];

  Widget getThumb(context, items) => GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => goToVideoDetails(context, this, items),
      child: IgnorePointer(
          child: Center(
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FadeInImage.assetNetwork(
                image: thumbnail,
                placeholder: 'assets/placeholder.png',
                height: 180,
                width: 380,
                fit: BoxFit.cover,
              ),
              Row(
                children: <Widget>[
                  Center(child: Text(title)),
                ],
              ),
            ],
          ),
        ),
      )));
}
