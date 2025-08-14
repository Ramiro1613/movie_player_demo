import 'package:flutter/material.dart';
import 'package:movie_demo_selector/models/movie.dart';

class AppProvider extends ChangeNotifier {
  List<Movie>? _favoriteMovies = [];
  void setSetFavorites(List<Movie>? data) {
    _favoriteMovies = data;
    notifyListeners();
  }

  List<Movie>? getFavorites() {
    return _favoriteMovies;
  }

  void clearFavorites() {
    _favoriteMovies = null;
    notifyListeners();
  }
}
