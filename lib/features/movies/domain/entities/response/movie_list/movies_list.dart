import 'package:moives/features/movies/domain/entities/response/movie_list/meta.dart';
import 'package:moives/features/movies/domain/entities/response/movie_list/movies_data_.dart';

class MoviesList {
  final String? status;
  final String? statusMessage;
  final Data? data;
  final Meta? meta;

  MoviesList({this.status, this.statusMessage, this.data, this.meta});
}
