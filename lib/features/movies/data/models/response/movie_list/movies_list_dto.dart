import 'package:json_annotation/json_annotation.dart';
import 'package:moives/features/movies/data/models/response/movie_list/meta_dto.dart';

import 'movies_data_dto.dart';

part 'movies_list_dto.g.dart';

@JsonSerializable()
class MoviesListDto {
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "status_message")
  final String? statusMessage;
  @JsonKey(name: "data")
  final DataDto? data;
  @JsonKey(name: "@meta")
  final MetaDto? meta;

  MoviesListDto ({
    this.status,
    this.statusMessage,
    this.data,
    this.meta,
  });

  factory MoviesListDto.fromJson(Map<String, dynamic> json) {
    return _$MoviesListDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MoviesListDtoToJson(this);
  }
}




