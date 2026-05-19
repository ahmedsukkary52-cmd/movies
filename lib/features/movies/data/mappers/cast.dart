import 'package:moives/features/movies/data/models/response/movie_details/movie_details_cast_dto.dart';
import 'package:moives/features/movies/domain/entities/response/movie_details/cast.dart';

extension Cast on CastDto {
  MovieCast toCast() {
    return MovieCast(
      imdbCode: imdbCode,
      characterName: characterName,
      name: name,
      urlSmallImage: urlSmallImage,
    );
  }
}
