import 'package:moives/features/movies/data/mappers/migration_mapper.dart';
import 'package:moives/features/movies/data/models/response/movie_list/meta_dto.dart';
import 'package:moives/features/movies/domain/entities/response/movie_list/meta.dart';

extension MetaMapper on MetaDto {
  Meta toMeta() {
    return Meta(
      apiVersion: apiVersion,
      executionTime: executionTime,
      migration: migration?.toMigration(),
    );
  }
}
