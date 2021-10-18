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
    items.remove(this._video);
    var t = SliverList(
        delegate: SliverChildListDelegate(
            <Widget>[Container(height: 250, child: video(this._video.url))]));
    return Scaffold(
        backgroundColor: Colors.black,
        body: CustomScrollView(
          slivers: <Widget>[t, otherVideos(context, items)],
        ));
  }

  Widget otherVideos(BuildContext context, List<Video> items) {
    return SliverList(
        delegate: SliverChildListDelegate(<Widget>[
      Container(
          height: 600,
          child: SingleChildScrollView(
              child: Column(
            children: <Widget>[
              const Text(
                'other videos',
                style: TextStyle(color: Colors.red, height: 1, fontSize: 30),
              ),
              ListView.builder(
                // scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                // Let the ListView know how many items it needs to build.
                itemCount: items.length,
                // Provide a builder function. This is where the magic happens.
                // Convert each item into a widget based on the type of item it is.
                itemBuilder: (context, index) {
                  final item = items[index];

                  return item.getThumb(context, items);
                },
              )
            ],
          )))
    ]));
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
