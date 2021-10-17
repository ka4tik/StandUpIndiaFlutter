import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:standup_india/model/mediaitem.dart';
import 'package:scoped_model/scoped_model.dart';

class AppModel extends Model {
  final Set<MediaItem>? _favorites = Set();
  static const _THEME_KEY = "theme_prefs_key";
  static const _FAVORITES_KEY = "media_favorites_key";

  AppModel() {
  }

  static List<ThemeData> _themes = [ThemeData.dark(), ThemeData.light()];
  int _currentTheme = 0;

  ThemeData get theme => _themes[_currentTheme];

  List<MediaItem> get favoriteMovies => _favorites!
      .where((MediaItem item) => item.type == MediaType.movie)
      .toList();

  List<MediaItem> get favoriteShows => _favorites!
      .where((MediaItem item) => item.type == MediaType.show)
      .toList();

  void toggleTheme() {
    _currentTheme = (_currentTheme + 1) % _themes.length;
    notifyListeners();
  }

  bool isItemFavorite(MediaItem item) =>
      _favorites?.where((MediaItem media) => media.id == item.id).length ==
          1;

  // TODO: this should ideally be stored in a database and accessed through a repository
  void toggleFavorites(MediaItem favoriteItem) {
    !isItemFavorite(favoriteItem)
        ? _favorites!.add(favoriteItem)
        : _favorites!
            .removeWhere((MediaItem item) => item.id == favoriteItem.id);

    notifyListeners();

  }
}
