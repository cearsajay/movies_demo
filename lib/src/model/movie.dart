import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie.g.dart';

final _dateFormat = DateFormat("yyyy-MM-dd");

DateTime _parseDate(String value) => _dateFormat.parse(value);

String _dateToString(DateTime value) => _dateFormat.format(value);

@JsonSerializable(fieldRename: FieldRename.snake)
class Movie extends Equatable {
  final int id;
  final String title;
  final String overview;
  final double popularity;
  final List<int> genreIds;
  final String originalLanguage;
  final String originalTitle;
  final String backdropPath;
  final String posterPath;
  @JsonKey(fromJson: _parseDate, toJson: _dateToString)
  final DateTime releaseDate;
  final int voteCount;
  final double voteAverage;

  const Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.popularity,
    required this.genreIds,
    required this.originalLanguage,
    required this.originalTitle,
    required this.backdropPath,
    required this.posterPath,
    required this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        overview,
        popularity,
        genreIds,
        originalLanguage,
        originalTitle,
        backdropPath,
        posterPath,
        releaseDate,
        voteAverage,
        voteCount,
      ];

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

  Map<String, dynamic> toJson() => _$MovieToJson(this);
}
