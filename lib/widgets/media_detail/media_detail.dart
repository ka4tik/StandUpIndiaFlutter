import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:standup_india/model/mediaitem.dart';
import 'package:standup_india/model/video.dart';
import 'package:standup_india/scoped_models/app_model.dart';
import 'package:standup_india/util/api_client.dart';
import 'package:standup_india/util/mediaproviders.dart';
import 'package:standup_india/widgets/media_list/media_list_item.dart';
import 'package:standup_india/widgets/utilviews/bottom_gradient.dart';
import 'package:standup_india/widgets/utilviews/text_bubble.dart';
import 'package:transparent_image/transparent_image.dart';

class MediaDetailScreen extends StatefulWidget {
  final MediaItem _mediaItem;

  MediaDetailScreen(this._mediaItem);

  @override
  MediaDetailScreenState createState() {
    return MediaDetailScreenState();
  }
}

class MediaDetailScreenState extends State<MediaDetailScreen> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 100), () => setState(() => _visible = true));
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        _buildAppBar(widget._mediaItem),
        _buildContentSection(widget._mediaItem)
      ],
    );
  }

  Widget _buildAppBar(MediaItem movie) {
    return SliverAppBar(
      expandedHeight: 240.0,
      pinned: true,
      actions: <Widget>[
        ScopedModelDescendant<AppModel>(
            builder: (context, child, AppModel model) => IconButton(
                icon: Icon(model.isItemFavorite(widget._mediaItem)
                    ? Icons.favorite
                    : Icons.favorite_border),
                onPressed: () => model.toggleFavorites(widget._mediaItem)))
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Hero(
              tag: "Movie-Tag-${widget._mediaItem.id}",
              child: FadeInImage.memoryNetwork(
                  fit: BoxFit.cover,
                  width: double.infinity,
                  placeholder: kTransparentImage,
                  image: widget._mediaItem.getBackDropUrl()),
            ),
            BottomGradient(),
            _buildMetaSection(movie)
          ],
        ),
      ),
    );
  }

  Widget _buildMetaSection(MediaItem mediaItem) {
    return AnimatedOpacity(
      opacity: _visible ? 1.0 : 0.0,
      duration: Duration(milliseconds: 500),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                TextBubble(
                  mediaItem.lovedRatio.toString() + " Likes/Dislikes",
                  backgroundColor: Color(0xffF47663),
                ),
                Container(
                  width: 8.0,
                ),
                TextBubble(
                    NumberFormatter.formatter(mediaItem.viewCount.toString()) + " views",
                    backgroundColor: Color(0xffF47663)),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(mediaItem.title,
                  style: TextStyle(color: Color(0xFFEEEEEE), fontSize: 20.0)),
            ),
            Row()
          ],
        ),
      ),
    );
  }

  Widget _buildContentSection(MediaItem media) {
    final ApiClient _apiClient = ApiClient();

    return FutureBuilder<List<Video>>(
      future: _apiClient.fetchVideosForComic(media.title),
      // this is a code smell. Make sure that the future is NOT recreated when build is called. Create the future in initState instead.
      builder: (context, snapshot) {
        Widget newsListSliver;
        if (snapshot.connectionState == ConnectionState.waiting) {
          newsListSliver = SliverToBoxAdapter(
            child: CircularProgressIndicator(),
          );
        } else {
          if (snapshot.hasError)
            return Text('Error: ${snapshot.error}');
          else
            newsListSliver = SliverList(
                delegate: SliverChildListDelegate(
                    <Widget>[VideoList(items: snapshot.data!)]));
        }

        return newsListSliver;
      },
    );
  }
}

class VideoList extends StatelessWidget {
  final List<Video> items;

  const VideoList({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: <Widget>[
        Text('videos'),
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
    ));
  }
}

/// The base class for the different types of items the list can contain
