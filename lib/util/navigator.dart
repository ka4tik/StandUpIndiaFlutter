import 'package:flutter/material.dart';
import 'package:standup_india/model/cast.dart';
import 'package:standup_india/model/mediaitem.dart';
import 'package:standup_india/model/tvseason.dart';
import 'package:standup_india/model/video.dart';
import 'package:standup_india/util/mediaproviders.dart';
import 'package:standup_india/widgets/actor_detail/actor_detail.dart';
import 'package:standup_india/widgets/favorites/favorite_screen.dart';
import 'package:standup_india/widgets/media_detail/media_detail.dart';
import 'package:standup_india/widgets/media_detail/video_detail.dart';
import 'package:standup_india/widgets/season_detail/season_detail_screen.dart';

goToMovieDetails(BuildContext context, MediaItem movie) {
  MediaProvider provider =
      (movie.type == MediaType.movie) ? MovieProvider() : ShowProvider();
  _pushWidgetWithFade(context, MediaDetailScreen(movie, provider));
}

goToSeasonDetails(BuildContext context, MediaItem show, TvSeason season) =>
    _pushWidgetWithFade(context, SeasonDetailScreen(show, season));

goToActorDetails(BuildContext context, Actor actor) {
  _pushWidgetWithFade(context, ActorDetailScreen(actor));
}
goToVideoDetails(BuildContext context, Video video, List<Video> items) {
  _pushWidgetWithFade(context, VideoDetailScreen(video, items));
}


goToFavorites(BuildContext context) {
  _pushWidgetWithFade(context, FavoriteScreen());
}

_pushWidgetWithFade(BuildContext context, Widget widget) {
  Navigator.of(context).push(
        PageRouteBuilder(
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child),
            pageBuilder: (BuildContext context, Animation animation,
                Animation secondaryAnimation) {
              return widget;
            }),
      );
}