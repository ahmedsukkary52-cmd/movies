import 'package:moives/features/movies/data/mappers/cast.dart';
import 'package:moives/features/movies/data/mappers/torrents_mapper.dart';
import 'package:moives/features/movies/data/models/response/movie_details/movie_details_movie_dto.dart';
import 'package:moives/features/movies/domain/entities/response/movie_details/details_movie.dart';

extension MovieDetailsMovieMapper on MovieDetailsMovieDto {
  MovieDetailsMovie toMovie() {
    return MovieDetailsMovie(
      dateUploaded: dateUploaded,
      dateUploadedUnix: dateUploadedUnix,
      url: url,
      ytTrailerCode: ytTrailerCode,
      year: year,
      torrents: torrents?.map((dto) => dto.toTorrents()).toList(),
      titleLong: titleLong,
      titleEnglish: titleEnglish,
      title: title,
      smallCoverImage: smallCoverImage,
      slug: slug,
      runtime: runtime,
      rating: rating,
      mpaRating: mediumCoverImage,
      mediumCoverImage: mediumCoverImage,
      largeCoverImage: largeCoverImage,
      language: language,
      imdbCode: imdbCode,
      id: id,
      genres: genres,
      descriptionFull: descriptionFull,
      backgroundImageOriginal: backgroundImageOriginal,
      backgroundImage: backgroundImage,
      descriptionIntro: descriptionIntro,
      likeCount: likeCount,
      cast: cast?.map((dto) => dto.toCast()).toList(),
      largeScreenshotImage1: largeScreenshotImage1,
      largeScreenshotImage2: largeScreenshotImage2,
      largeScreenshotImage3: largeScreenshotImage3,
      mediumScreenshotImage1: mediumScreenshotImage1,
      mediumScreenshotImage2: mediumScreenshotImage2,
      mediumScreenshotImage3: mediumScreenshotImage3,
    );
  }
}
