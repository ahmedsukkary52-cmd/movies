import 'package:json_annotation/json_annotation.dart';

part 'movie_details_cast_dto.g.dart';

@JsonSerializable()
class CastDto {
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "character_name")
  final String? characterName;
  @JsonKey(name: "url_small_image")
  final String? urlSmallImage;
  @JsonKey(name: "imdb_code")
  final String? imdbCode;

  CastDto({this.name, this.characterName, this.urlSmallImage, this.imdbCode});

  factory CastDto.fromJson(Map<String, dynamic> json) {
    return _$CastDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CastDtoToJson(this);
  }
}
