import 'package:moives/features/movies/data/mappers/data_mapper.dart';
import 'package:moives/features/movies/data/mappers/meta_mapper.dart';
import 'package:moives/features/movies/data/models/response/movie_list/movies_list_dto.dart';
import 'package:moives/features/movies/domain/entities/response/movie_list/movies_list.dart';

extension MovieListMapper on MoviesListDto {
  MoviesList toMovieList() {
    return MoviesList(
      data: data?.toData(),
      meta: meta?.toMeta(),
      status: status,
      statusMessage: statusMessage,
    );
  }
}
