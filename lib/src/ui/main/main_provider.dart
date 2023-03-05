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

  // TODO: Implement pagination for popular movies.
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

  Future<void> refresh() {
    _hasError = false;
    _movies.clear();
    notifyListeners();
    return getPopularMovies();
  }
}
