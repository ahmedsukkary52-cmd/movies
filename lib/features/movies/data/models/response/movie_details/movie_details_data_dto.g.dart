// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_details_data_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieDetailsDataDto _$MovieDetailsDataDtoFromJson(Map<String, dynamic> json) =>
    MovieDetailsDataDto(
      movie: json['movie'] == null
          ? null
          : MovieDetailsMovieDto.fromJson(
              json['movie'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$MovieDetailsDataDtoToJson(
  MovieDetailsDataDto instance,
) => <String, dynamic>{'movie': instance.movie};
