// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movies_list_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MoviesListDto _$MoviesListDtoFromJson(Map<String, dynamic> json) =>
    MoviesListDto(
      status: json['status'] as String?,
      statusMessage: json['status_message'] as String?,
      data: json['data'] == null
          ? null
          : DataDto.fromJson(json['data'] as Map<String, dynamic>),
      meta: json['@meta'] == null
          ? null
          : MetaDto.fromJson(json['@meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MoviesListDtoToJson(MoviesListDto instance) =>
    <String, dynamic>{
      'status': instance.status,
      'status_message': instance.statusMessage,
      'data': instance.data,
      '@meta': instance.meta,
    };
