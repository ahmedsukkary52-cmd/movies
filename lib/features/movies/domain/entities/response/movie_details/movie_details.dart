import 'package:moives/features/movies/domain/entities/response/movie_details/movie_details_data.dart';
import 'package:moives/features/movies/domain/entities/response/movie_list/meta.dart';

class MovieDetails {
  final String? status;
  final String? statusMessage;
  final MovieDetailsData? data;
  final Meta? meta;

  MovieDetails({this.status, this.statusMessage, this.data, this.meta});
}
