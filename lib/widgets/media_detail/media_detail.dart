import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:standup_india/model/cast.dart';
import 'package:standup_india/model/mediaitem.dart';
import 'package:standup_india/model/tvseason.dart';
import 'package:standup_india/model/video.dart';
import 'package:standup_india/scoped_models/app_model.dart';
import 'package:standup_india/util/api_client.dart';
import 'package:standup_india/util/mediaproviders.dart';
import 'package:standup_india/widgets/utilviews/bottom_gradient.dart';
import 'package:standup_india/widgets/utilviews/text_bubble.dart';

class MediaDetailScreen extends StatefulWidget {
  final MediaItem _mediaItem;
  final MediaProvider provider;
  final ApiClient _apiClient = ApiClient();

  MediaDetailScreen(this._mediaItem, this.provider);

  @override
  MediaDetailScreenState createState() {
    return MediaDetailScreenState();
  }
}

class MediaDetailScreenState extends State<MediaDetailScreen> {
  List<Actor> _actorList = [];
  List<TvSeason> _seasonList = [];
  List<MediaItem> _similarMedia = [];
  dynamic _mediaDetails;
  bool _visible = false;
  final ApiClient _apiClient = ApiClient();

  @override
  void initState() {
    super.initState();
    _loadCast();
    _loadDetails();
    _loadSimilar();
    if (widget._mediaItem.type == MediaType.show) _loadSeasons();

    Timer(Duration(milliseconds: 100), () => setState(() => _visible = true));
  }

  void _loadCast() async {
    try {
      List<Actor> cast = await widget.provider.loadCast(widget._mediaItem.id);
      setState(() => _actorList = cast);
    } catch (e) {}
  }

  void _loadDetails() async {
    try {
      dynamic details = await widget.provider.getDetails(widget._mediaItem.id);
      setState(() => _mediaDetails = details);
    } catch (e) {
      e.toString();
    }
  }

  void _loadSeasons() async {
    try {
      List<TvSeason> seasons =
          await widget._apiClient.getShowSeasons(widget._mediaItem.id);
      setState(() => _seasonList = seasons);
    } catch (e) {}
  }

  void _loadSimilar() async {
    try {
      List<MediaItem> similar =
          await widget.provider.getSimilar(widget._mediaItem.id);
      setState(() => _similarMedia = similar);
    } catch (e) {}
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
              child: FadeInImage.assetNetwork(
                  fit: BoxFit.cover,
                  width: double.infinity,
                  placeholder: "assets/placeholder.png",
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
                  mediaItem.getReleaseYear().toString(),
                  backgroundColor: Color(0xffF47663),
                ),
                Container(
                  width: 8.0,
                ),
                TextBubble(mediaItem.voteAverage.toString(),
                    backgroundColor: Color(0xffF47663)),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(mediaItem.title,
                  style: TextStyle(color: Color(0xFFEEEEEE), fontSize: 20.0)),
            ),
            Row(
            )
          ],
        ),
      ),
    );
  }



  Widget _buildContentSection(MediaItem media) {
    final ApiClient _apiClient = ApiClient();

    return FutureBuilder<List<Video>>(
      future: _apiClient.fetchVideosForComic(media.title), // this is a code smell. Make sure that the future is NOT recreated when build is called. Create the future in initState instead.
      builder: (context, snapshot){
        Widget newsListSliver;
          if (snapshot.connectionState ==  ConnectionState.waiting) {
            newsListSliver =
                SliverToBoxAdapter(child: CircularProgressIndicator(),);
          }
            else {
            if (snapshot.hasError)
              return Text('Error: ${snapshot.error}');
            else
              newsListSliver =
                  SliverList(delegate: SliverChildListDelegate(<Widget>[
                    VideoList(items: snapshot.data!)]));
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

    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
          // Let the ListView know how many items it needs to build.
          itemCount: items.length,
          // Provide a builder function. This is where the magic happens.
          // Convert each item into a widget based on the type of item it is.
          itemBuilder: (context, index) {
            final item = items[index];

            return item.getThumb(context, items);
          },
        );
  }
}

/// The base class for the different types of items the list can contain