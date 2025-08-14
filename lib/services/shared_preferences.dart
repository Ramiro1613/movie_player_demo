import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movie_demo_selector/models/movie.dart';
import 'package:movie_demo_selector/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLoginService {
  Future<bool> guardarUsuario(User user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = jsonEncode(user.toJson());
      await prefs.setString('usuario_device', userJson);
      return true;
    } catch (e) {
      debugPrint('Error guardando usuario: $e');
      return false;
    }
  }

  Future<bool> cerrarSesion() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('usuario_device');
      return true;
    } catch (e) {
      debugPrint('Error eliminando usuario: $e');
      return false;
    }
  }

  Future<User?> getUsuario() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('usuario_device');
    if (userJson != null) {
      final Map<String, dynamic> data = jsonDecode(userJson);
      return User.fromJson(data);
    }
    return null;
  }

  static const String _moviesKey = 'movies_device';

  Future<bool> saveMovies(List<Movie> movies) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final moviesJsonList = movies.map((movie) => movie.toJson()).toList();
      final moviesJsonString = jsonEncode(moviesJsonList);

      await prefs.setString(_moviesKey, moviesJsonString);
      return true;
    } catch (e) {
      debugPrint('Error guardando películas: $e');
      return false;
    }
  }

  Future<List<Movie>> getMovies() async {
    final prefs = await SharedPreferences.getInstance();
    final moviesJsonString = prefs.getString(_moviesKey);

    if (moviesJsonString != null) {
      try {
        final List<dynamic> decodedList = jsonDecode(moviesJsonString);
        return decodedList.map((data) => Movie.fromJson(data)).toList();
      } catch (e) {
        debugPrint('Error decodificando películas: $e');
        return [];
      }
    }
    return [];
  }

  Future<bool> deleteMovies() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_moviesKey);
      return true;
    } catch (e) {
      debugPrint('Error deleting movies: $e');
      return false;
    }
  }
}
