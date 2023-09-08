import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:movies_demo/src/data/repository/movie_repository.dart';
import 'package:movies_demo/src/model/movie.dart';

class MainProvider extends ChangeNotifier {
  final MovieRepository movieRepository;

  MainProvider({
    required this.movieRepository,
  });

  List<Movie> _movies = [];
  bool _isLoading = false;
  bool _hasError = false;

  bool get hasError => _hasError;

  bool get isLoading => _isLoading;

  UnmodifiableListView<Movie> get movies => UnmodifiableListView(_movies);

  /// `getPopularMovies()` : fetches popular movies from TMDB movies database
  ///
  /// TODO: Implement pagination in this api, pass page parameter in api for pagination.
  Future<void> getPopularMovies() async {
    _isLoading = true;
    _hasError = false;
    notifyListeners();

    try {
      final result = await movieRepository.getPopularMovies(page: 1);
      _movies = result.results;
    } catch (error) {
      _hasError = true;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// `refresh()` : sets provider to its initial state and invokes [getPopularMovies] method for fetching movies.
  Future<void> refresh() {
    _hasError = false;
    _movies = [];
    notifyListeners();
    return getPopularMovies();
  }
}
