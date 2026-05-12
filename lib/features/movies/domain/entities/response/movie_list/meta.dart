import 'package:moives/features/movies/domain/entities/response/movie_list/migration.dart';

class Meta {
  final Migration? migration;

  final int? apiVersion;

  final String? executionTime;

  Meta({this.migration, this.apiVersion, this.executionTime});
}
