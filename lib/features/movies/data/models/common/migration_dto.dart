import 'package:json_annotation/json_annotation.dart';

part 'migration_dto.g.dart';

@JsonSerializable()
class MigrationDto {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "old_base")
  final String? oldBase;
  @JsonKey(name: "new_base")
  final String? newBase;
  @JsonKey(name: "sunset")
  final String? sunset;

  MigrationDto ({
    this.message,
    this.oldBase,
    this.newBase,
    this.sunset,
  });

  factory MigrationDto.fromJson(Map<String, dynamic> json) {
    return _$MigrationDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MigrationDtoToJson(this);
  }
}
