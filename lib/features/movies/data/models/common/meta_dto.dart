import 'package:json_annotation/json_annotation.dart';
import 'package:moives/features/movies/data/models/common/migration_dto.dart';

part 'meta_dto.g.dart';

@JsonSerializable()
class MetaDto {
  @JsonKey(name: "migration")
  final MigrationDto? migration;

  @JsonKey(name: "api_version")
  final int? apiVersion;

  @JsonKey(name: "execution_time")
  final String? executionTime;

  MetaDto({
    this.migration,
    this.apiVersion,
    this.executionTime,
  });

  factory MetaDto.fromJson(Map<String, dynamic> json) =>
      _$MetaDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MetaDtoToJson(this);
}

