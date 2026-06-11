// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_details_cast_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CastDto _$CastDtoFromJson(Map<String, dynamic> json) => CastDto(
  name: json['name'] as String?,
  characterName: json['character_name'] as String?,
  urlSmallImage: json['url_small_image'] as String?,
  imdbCode: json['imdb_code'] as String?,
);

Map<String, dynamic> _$CastDtoToJson(CastDto instance) => <String, dynamic>{
  'name': instance.name,
  'character_name': instance.characterName,
  'url_small_image': instance.urlSmallImage,
  'imdb_code': instance.imdbCode,
};
