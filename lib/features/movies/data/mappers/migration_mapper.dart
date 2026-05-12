import 'package:moives/features/movies/data/models/response/movie_list/migration_dto.dart';
import 'package:moives/features/movies/domain/entities/response/movie_list/migration.dart';

extension MigrationMapper on MigrationDto {
  Migration toMigration() {
    return Migration(
      message: message,
      newBase: newBase,
      oldBase: oldBase,
      sunset: sunset,
    );
  }
}
