

import 'package:flutter/cupertino.dart';
import 'package:standup_india/model/mediaitem.dart';
import 'package:standup_india/util/navigator.dart';

class Video {
  late String title;
  late String url;
  late String thumbnail;
  late String comic;
   // Video({required this.title, required this.thumbnail, required this.url, required this.comic});

  factory Video(Map jsonMap) => Video._internalFromJson(jsonMap);

  Video._internalFromJson(Map jsonMap):
        url = jsonMap['url'],
        comic = jsonMap['comic'],
       title = jsonMap['title'],
      thumbnail = jsonMap['thumbnail'];

  Widget getThumb(context, items) =>
      GestureDetector(
        onTap: () => goToVideoDetails(context, this, items),
        child: FadeInImage.assetNetwork(
          image: thumbnail,
          placeholder: 'assets/placeholder.png',
          height: 150.0,
          fit: BoxFit.cover,
        ),
      );

}
