import 'package:flutter/material.dart';
import 'package:standup_india/model/mediaitem.dart';
import 'package:standup_india/model/video.dart';
import 'package:standup_india/util/mediaproviders.dart';
import 'package:standup_india/util/utils.dart';
import 'package:standup_india/widgets/media_list/media_list_item.dart';

class MediaList extends StatefulWidget {
  MediaList(this.type, this.category, {Key? key}) : super(key: key);

  final MovieProvider movieProvider = MovieProvider();
  final VideoProvider videoProvider = VideoProvider();

  final String category;
  final String type;//comics,videos

  @override
  _MediaListState createState() => _MediaListState();
}

class _MediaListState extends State<MediaList> {
  List<MediaItem> _movies = [];
  List<Video> _videos = [];
  int _pageNumber = 1;
  LoadingState _loadingState = LoadingState.LOADING;
  bool _isLoading = false;

  _loadNextPage() async {
    _isLoading = true;
    try {
      var nextMovies;
      if (widget.type == 'comics') {
         nextMovies =
        await widget.movieProvider.loadMedia(
            widget.category, page: _pageNumber);
         setState(() {
           _loadingState = LoadingState.DONE;
           _movies.addAll(nextMovies);
           _isLoading = false;
           _pageNumber++;
         });
      } else {
        nextMovies = await widget.videoProvider.loadVideos(
            widget.category, page: _pageNumber);
        setState(() {
          _loadingState = LoadingState.DONE;
          _videos.addAll(nextMovies);
          _isLoading = false;
          _pageNumber++;
        });
      }

    } catch (e) {
      _isLoading = false;
      if (_loadingState == LoadingState.LOADING) {
        setState(() => _loadingState = LoadingState.ERROR);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: _getContentSection());
  }

  Widget _getContentSection() {
    switch (_loadingState) {
      case LoadingState.DONE:
        if (widget.type == 'comics') {
          return ListView.builder(
              itemCount: _movies.length,
              itemBuilder: (BuildContext context, int index) {
                if (!_isLoading && index > (_movies.length * 0.7)) {
                  _loadNextPage();
                }

                return MediaListItem(_movies[index]);
              });
        } else {
          return ListView.builder(
              itemCount: _videos.length,
              itemBuilder: (BuildContext context, int index) {
                if (!_isLoading && index > (_videos.length * 0.7)) {
                  _loadNextPage();
                }

                return VideoListItem(_videos[index], _videos);
              });
        }
      case LoadingState.ERROR:
        return Text('Sorry, there was an error loading the data!');
      case LoadingState.LOADING:
        return CircularProgressIndicator();
      default:
        return Container();
    }
  }
}
