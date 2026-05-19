import 'package:json_annotation/json_annotation.dart';
import 'package:moives/features/movies/data/models/response/movie_details/movie_details_movie_dto.dart';

part 'movie_details_data_dto.g.dart';

@JsonSerializable()
class MovieDetailsDataDto {
  @JsonKey(name: "movie")
  final MovieDetailsMovieDto? movie;

  MovieDetailsDataDto({this.movie});

  factory MovieDetailsDataDto.fromJson(Map<String, dynamic> json) {
    return _$MovieDetailsDataDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MovieDetailsDataDtoToJson(this);
  }
}
