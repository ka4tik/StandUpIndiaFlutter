import 'dart:async';

import 'package:standup_india/model/cast.dart';
import 'package:standup_india/model/mediaitem.dart';
import 'package:standup_india/model/video.dart';
import 'package:standup_india/util/api_client.dart';


class MovieProvider {
  MovieProvider();

  ApiClient _apiClient = ApiClient();

  Future<List<MediaItem>> loadMedia(String category, {int page: 1}) {
    return _apiClient.fetchMovies();
  }
}

class VideoProvider {
  VideoProvider();

  ApiClient _apiClient = ApiClient();

  Future<List<Video>> loadVideos(String category, {int page: 1}) {
    return _apiClient.fetchShows();
  }
}
