import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:standup_india/util/navigator.dart';
import 'package:standup_india/widgets/media_list/media_list_item.dart';

class Video {
  late String title;
  late String url;
  late String thumbnail;
  late String comic;
  late int viewCount = 0;

  // Video({required this.title, required this.thumbnail, required this.url, required this.comic});

  factory Video(Map jsonMap) => Video._internalFromJson(jsonMap);

  Video._internalFromJson(Map jsonMap)
      : url = jsonMap['url'],
        comic = jsonMap['comic'],
        title = jsonMap['title'],
        thumbnail = jsonMap['thumbnail'],
        viewCount = jsonMap['viewCount'];

  Widget getThumb(context, items) => VideoListItem(this, items);
}
