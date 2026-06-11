// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_suggestions_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieSuggestionsDto _$MovieSuggestionsDtoFromJson(Map<String, dynamic> json) =>
    MovieSuggestionsDto(
      status: json['status'] as String?,
      statusMessage: json['status_message'] as String?,
      data: json['data'] == null
          ? null
          : MovieSuggestionsDataDto.fromJson(
              json['data'] as Map<String, dynamic>,
            ),
      meta: json['@meta'] == null
          ? null
          : MetaDto.fromJson(json['@meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MovieSuggestionsDtoToJson(
  MovieSuggestionsDto instance,
) => <String, dynamic>{
  'status': instance.status,
  'status_message': instance.statusMessage,
  'data': instance.data,
  '@meta': instance.meta,
};
