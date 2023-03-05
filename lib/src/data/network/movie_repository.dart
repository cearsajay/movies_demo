import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:movies_demo/src/data/repository/movie_repository.dart';
import 'package:movies_demo/src/model/movie_list_result.dart';

class NetworkMovieRepository extends MovieRepository {
  final Dio dio;

  const NetworkMovieRepository({
    required this.dio,
  });

  @override
  Future<MovieListResult> getPopularMovies({int page = 1}) async {
    try {
      final response = await dio.get("movie/popular", queryParameters: {"page": page});
      return MovieListResult.fromJson(response.data);
    } catch (error) {
      debugPrint(error.toString());
      throw const MovieListException();
    }
  }

  @override
  Future<MovieListResult> searchMovie({String query = "", int page = 1}) {
    // TODO: Integrate search api here
    throw UnimplementedError();
  }
}
