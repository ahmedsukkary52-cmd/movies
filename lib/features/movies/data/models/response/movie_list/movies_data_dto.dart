import 'package:json_annotation/json_annotation.dart';
import 'package:moives/features/movies/data/models/response/movie_list/movies_dto.dart';
part 'movies_data_dto.g.dart';

@JsonSerializable()
class DataDto {
  @JsonKey(name: "movie_count")
  final int? movieCount;
  @JsonKey(name: "limit")
  final int? limit;
  @JsonKey(name: "page_number")
  final int? pageNumber;
  @JsonKey(name: "movies")
  final List<MoviesDto>? movies;

  DataDto({this.movieCount, this.limit, this.pageNumber, this.movies});

  factory DataDto.fromJson(Map<String, dynamic> json) {
    return _$DataDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DataDtoToJson(this);
  }
}
