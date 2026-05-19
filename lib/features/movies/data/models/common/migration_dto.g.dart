// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'migration_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MigrationDto _$MigrationDtoFromJson(Map<String, dynamic> json) => MigrationDto(
  message: json['message'] as String?,
  oldBase: json['old_base'] as String?,
  newBase: json['new_base'] as String?,
  sunset: json['sunset'] as String?,
);

Map<String, dynamic> _$MigrationDtoToJson(MigrationDto instance) =>
    <String, dynamic>{
      'message': instance.message,
      'old_base': instance.oldBase,
      'new_base': instance.newBase,
      'sunset': instance.sunset,
    };
