import 'package:moives/features/movies/data/mappers/movies_mapper.dart';
import 'package:moives/features/movies/data/models/response/movie_list/movies_data_dto.dart';
import 'package:moives/features/movies/domain/entities/response/movie_list/movies_data_.dart';

extension DataMapper on DataDto {
  Data toData() {
    return Data(
      limit: limit,
      movieCount: movieCount,
      movies: movies?.map((dataDto) => dataDto.toMovie()).toList(),
      pageNumber: pageNumber,
    );
  }
}
