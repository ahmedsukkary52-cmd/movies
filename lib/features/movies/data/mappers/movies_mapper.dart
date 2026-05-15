import 'package:moives/features/movies/data/mappers/torrents_mapper.dart';
import 'package:moives/features/movies/data/models/response/movie_list/movies_dto.dart';
import 'package:moives/features/movies/domain/entities/response/movie_list/movie.dart';

extension MoviesMapper on MoviesDto {
  Movie toMovie() {
    return Movie(
      backgroundImage: backgroundImage,
      backgroundImageOriginal: backgroundImageOriginal,
      dateUploaded: dateUploaded,
      dateUploadedUnix: dateUploadedUnix,
      descriptionFull: descriptionFull,
      genres: genres,
      id: id,
      imdbCode: imdbCode,
      language: language,
      largeCoverImage: largeCoverImage,
      mediumCoverImage: mediumCoverImage,
      mpaRating: mpaRating,
      rating: rating,
      runtime: runtime,
      slug: slug,
      smallCoverImage: smallCoverImage,
      state: state,
      summary: summary,
      synopsis: synopsis,
      title: title,
      titleEnglish: titleEnglish,
      titleLong: titleLong,
      torrents: torrents
          ?.map((torrentsDto) => torrentsDto.toTorrents())
          .toList(),
      url: url,
      year: year,
      ytTrailerCode: ytTrailerCode,
    );
  }
}
