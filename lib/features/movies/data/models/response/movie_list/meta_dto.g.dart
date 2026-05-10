// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meta_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MetaDto _$MetaDtoFromJson(Map<String, dynamic> json) => MetaDto(
  migration: json['migration'] == null
      ? null
      : MigrationDto.fromJson(json['migration'] as Map<String, dynamic>),
  apiVersion: (json['api_version'] as num?)?.toInt(),
  executionTime: json['execution_time'] as String?,
);

Map<String, dynamic> _$MetaDtoToJson(MetaDto instance) => <String, dynamic>{
  'migration': instance.migration,
  'api_version': instance.apiVersion,
  'execution_time': instance.executionTime,
};
