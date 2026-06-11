import 'package:json_annotation/json_annotation.dart';
import 'package:moives/features/movies/data/models/common/meta_dto.dart';
import 'package:moives/features/movies/data/models/response/movie_details/movie_details_data_dto.dart';

part 'movie_details_dto.g.dart';

@JsonSerializable()
class MovieDetailsDto {
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "status_message")
  final String? statusMessage;
  @JsonKey(name: "data")
  final MovieDetailsDataDto? data;
  @JsonKey(name: "@meta")
  final MetaDto? meta;

  MovieDetailsDto({this.status, this.statusMessage, this.data, this.meta});

  factory MovieDetailsDto.fromJson(Map<String, dynamic> json) {
    return _$MovieDetailsDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MovieDetailsDtoToJson(this);
  }
}
