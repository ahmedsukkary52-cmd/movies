import 'package:json_annotation/json_annotation.dart';
import 'package:moives/features/movies/data/models/common/meta_dto.dart';
import 'package:moives/features/movies/data/models/response/movie_suggestions/movie_suggestions_data_dto.dart';

part 'movie_suggestions_dto.g.dart';

@JsonSerializable()
class MovieSuggestionsDto {
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "status_message")
  final String? statusMessage;
  @JsonKey(name: "data")
  final MovieSuggestionsDataDto? data;
  @JsonKey(name: "@meta")
  final MetaDto? meta;

  MovieSuggestionsDto({this.status, this.statusMessage, this.data, this.meta});

  factory MovieSuggestionsDto.fromJson(Map<String, dynamic> json) {
    return _$MovieSuggestionsDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MovieSuggestionsDtoToJson(this);
  }
}
