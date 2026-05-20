import 'package:moives/features/movies/domain/entities/response/movie_list/meta.dart';
import 'package:moives/features/movies/domain/entities/response/movie_suggestions/movie_suggestions_data.dart';

class MovieSuggestions {
  final String? status;
  final String? statusMessage;
  final MovieSuggestionsData? data;
  final Meta? meta;

  MovieSuggestions({this.status, this.statusMessage, this.data, this.meta});
}
