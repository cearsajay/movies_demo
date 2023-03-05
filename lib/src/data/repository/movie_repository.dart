import 'package:movies_demo/src/model/movie_list_result.dart';

abstract class MovieRepository {
  const MovieRepository();

  Future<MovieListResult> getPopularMovies({int page});

  Future<MovieListResult> searchMovie({String query, int page});
}

class MovieListException implements Exception {
  const MovieListException();
}
