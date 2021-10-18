import 'package:flutter/material.dart';
import 'package:standup_india/model/video.dart';
import 'package:standup_india/util/api_client.dart';
import 'package:standup_india/util/navigator.dart';
import 'package:standup_india/yt.dart';

class VideoDetailScreen extends StatelessWidget {
  final Video _video;
  final List<Video> items;
  final ApiClient _apiClient = ApiClient();

  VideoDetailScreen(this._video, this.items);

  @override
  Widget build(BuildContext context) {
    var  t = SliverList(
        delegate: SliverChildListDelegate(<Widget>[
          Container(
            height: 300,
            child: video(this._video.url)
          )]));
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        body: CustomScrollView(
          slivers: <Widget>[t, otherVideos(context, items)],
        ));
  }

  Widget otherVideos(BuildContext context, List<Video> items) {

    return SliverList(
        delegate: SliverChildListDelegate(<Widget>[
        Container(
          height: 300,
          child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                final item = items[index];

                return item.getThumb(context, items);
              }),
        )]));

  }
}

class MessageItem {
  final String sender;
  final String body;
  final String thumbnail;
  final String url;

  MessageItem(this.sender, this.body, this.thumbnail, this.url);

  @override
  Widget buildTitle(BuildContext context) => Text(sender);

  @override
  Widget buildSubtitle(BuildContext context) => Text(body);
}
