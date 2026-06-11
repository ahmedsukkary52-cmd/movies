import 'package:json_annotation/json_annotation.dart';
import 'package:moives/features/movies/data/models/response/movie_list/movies_dto.dart';

part 'movie_suggestions_data_dto.g.dart';

@JsonSerializable()
class MovieSuggestionsDataDto {
  @JsonKey(name: "movie_count")
  final int? movieCount;
  @JsonKey(name: "movies")
  final List<MoviesDto>? movies;

  MovieSuggestionsDataDto({this.movieCount, this.movies});

  factory MovieSuggestionsDataDto.fromJson(Map<String, dynamic> json) {
    return _$MovieSuggestionsDataDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MovieSuggestionsDataDtoToJson(this);
  }
}
