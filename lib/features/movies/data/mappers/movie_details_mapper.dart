import 'package:moives/features/movies/data/mappers/meta_mapper.dart';
import 'package:moives/features/movies/data/mappers/movie_details_data_mapper.dart';
import 'package:moives/features/movies/data/models/response/movie_details/movie_details_dto.dart';
import 'package:moives/features/movies/domain/entities/response/movie_details/movie_details.dart';

extension MovieDetailsMapper on MovieDetailsDto {
  MovieDetails toMovieDetails() {
    return MovieDetails(
      data: data?.toData(),
      meta: meta?.toMeta(),
      status: status,
      statusMessage: statusMessage,
    );
  }
}
