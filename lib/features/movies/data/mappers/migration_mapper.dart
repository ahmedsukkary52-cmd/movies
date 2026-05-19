import 'package:moives/features/movies/data/models/common/migration_dto.dart';
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
