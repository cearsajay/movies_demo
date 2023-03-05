import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'movie.dart';

part 'movie_list_result.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MovieListResult extends Equatable {
  final int page;
  final List<Movie> results;
  final int totalPages;
  final int totalResults;

  const MovieListResult({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  @override
  List<Object?> get props => [page, results, totalPages, totalResults];

  factory MovieListResult.fromJson(Map<String, dynamic> json) => _$MovieListResultFromJson(json);

  Map<String, dynamic> toJson() => _$MovieListResultToJson(this);
}
