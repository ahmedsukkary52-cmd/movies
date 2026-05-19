import 'package:moives/features/movies/data/models/response/movie_details/movie_details_data_dto.dart';
import 'package:moives/features/movies/domain/entities/response/movie_details/movie_details_data.dart';

import 'movie_details_movie_mapper.dart';

extension MovieDetailsDataMapper on MovieDetailsDataDto {
  MovieDetailsData toData() {
    return MovieDetailsData(movie: movie!.toMovie());
  }
}
