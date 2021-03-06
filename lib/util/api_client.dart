import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:standup_india/model/cast.dart';
import 'package:standup_india/model/episode.dart';
import 'package:standup_india/model/mediaitem.dart';
import 'package:standup_india/model/searchresult.dart';
import 'package:standup_india/model/tvseason.dart';
import 'package:standup_india/model/video.dart';
import 'package:standup_india/util/constants.dart';

class ApiClient {
  static final _client = ApiClient._internal();
  final _http = HttpClient();

  ApiClient._internal();

  // final String baseUrl = '10.0.2.2:8080';
  final String baseUrl = 'agile-retreat-82679.herokuapp.com';

  factory ApiClient() => _client;

  Future<dynamic> _getJson(Uri uri) async {
    try {
      var response = await (await _http.getUrl(uri)).close();
      var transformedResponse = await response.transform(utf8.decoder).join();
      return json.decode(transformedResponse);
    }
    catch(e) {
      print('Exception occurred');
    }

  }

  Future<List<MediaItem>> fetchMovies(){

   // String j = "[{\"id\": 123, \"title\": \"Tanmay Bhat\", \"poster_path\": \"https://upload.wikimedia.org/wikipedia/commons/d/df/Tanmay_Bhat.png\"},{\"id\": 432, \"title\": \"T Bhat\", \"poster_path\": \"https://upload.wikimedia.org/wikipedia/commons/d/df/Tanmay_Bhat.png\"}]";
    var url = Uri.http(baseUrl, '');

    return _getJson(url).then((data) => data.
        map<MediaItem>((item) => MediaItem(item, MediaType.movie))
        .toList());
  }

  Future<List<Video>> fetchVideosForComic(String comic) async{

    // String j = "[{\"id\": 123, \"title\": \"Tanmay Bhat\", \"poster_path\": \"https://upload.wikimedia.org/wikipedia/commons/d/df/Tanmay_Bhat.png\"},{\"id\": 432, \"title\": \"T Bhat\", \"poster_path\": \"https://upload.wikimedia.org/wikipedia/commons/d/df/Tanmay_Bhat.png\"}]";
    var url = Uri.http(baseUrl, '/videos/' +  comic);

    return _getJson(url).then((data) => data.
    map<Video>((item) => Video(item))
        .toList());
  }

  Future<List<MediaItem>> getSimilarMedia(int mediaId,
      {String type: "movie"}) async {
    var url = Uri.https(baseUrl, '3/$type/$mediaId/similar', {
      'api_key': API_KEY,
    });

    return _getJson(url).then((json) => json['results']).then((data) => data
        .map<MediaItem>((item) => MediaItem(
            item, (type == "movie") ? MediaType.movie : MediaType.show))
        .toList());
  }

  Future<List<MediaItem>> getMoviesForActor(int actorId) async {
    var url = Uri.https(baseUrl, '3/discover/movie', {
      'api_key': API_KEY,
      'with_cast': actorId.toString(),
      'sort_by': 'popularity.desc'
    });

    return _getJson(url).then((json) => json['results']).then((data) => data
        .map<MediaItem>((item) => MediaItem(item, MediaType.movie))
        .toList());
  }

  Future<List<MediaItem>> getShowsForActor(int actorId) async {
    var url = Uri.https(baseUrl, '3/person/$actorId/tv_credits', {
      'api_key': API_KEY,
    });

    return _getJson(url).then((json) => json['cast']).then((data) => data
        .map<MediaItem>((item) => MediaItem(item, MediaType.show))
        .toList());
  }

  Future<List<Actor>> getMediaCredits(int mediaId,
      {String type: "movie"}) async {
    var url =
        Uri.https(baseUrl, '3/$type/$mediaId/credits', {'api_key': API_KEY});

    return _getJson(url).then((json) =>
        json['cast'].map<Actor>((item) => Actor.fromJson(item)).toList());
  }

  Future<dynamic> getMediaDetails(int mediaId, {String type: "movie"}) async {
    var url = Uri.https(baseUrl, '3/$type/$mediaId', {'api_key': API_KEY});

    return _getJson(url);
  }

  Future<List<TvSeason>> getShowSeasons(int showId) async {
    var detailJson = await getMediaDetails(showId, type: 'tv');
    return detailJson['seasons']
        .map<TvSeason>((item) => TvSeason.fromMap(item))
        .toList();
  }

  Future<List<SearchResult>> getSearchResults(String query) {
    var url = Uri
        .https(baseUrl, '3/search/multi', {'api_key': API_KEY, 'query': query});

    return _getJson(url).then((json) => json['results']
        .map<SearchResult>((item) => SearchResult.fromJson(item))
        .toList());
  }

  Future<List<Video>> fetchVideosByViews() {
    var url = Uri.http(baseUrl, 'videosByViews');

    return _getJson(url).then((data) => data
        .map<Video>((item) => Video(item))
        .toList());
  }

  Future<List<Video>> fetchVideosByLikedCount() {
    var url = Uri.http(baseUrl, 'videosByLikedCount');

    return _getJson(url).then((data) => data
        .map<Video>((item) => Video(item))
        .toList());
  }

  Future<List<Video>> fetchVideosByPublishedTime() {
    var url = Uri.http(baseUrl, 'videosByPublishedTime');

    return _getJson(url).then((data) => data
        .map<Video>((item) => Video(item))
        .toList());
  }

  Future<List<Episode>> fetchEpisodes(int showId, int seasonNumber) {
    var url = Uri.https(baseUrl, '3/tv/$showId/season/$seasonNumber', {
      'api_key': API_KEY,
    });

    return _getJson(url).then((json) => json['episodes']).then(
        (data) => data.map<Episode>((item) => Episode.fromJson(item)).toList());
  }
}
