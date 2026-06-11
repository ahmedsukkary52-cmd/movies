// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_details_movie_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieDetailsMovieDto _$MovieDetailsMovieDtoFromJson(
  Map<String, dynamic> json,
) => MovieDetailsMovieDto(
  id: (json['id'] as num?)?.toInt(),
  url: json['url'] as String?,
  imdbCode: json['imdb_code'] as String?,
  title: json['title'] as String?,
  titleEnglish: json['title_english'] as String?,
  titleLong: json['title_long'] as String?,
  slug: json['slug'] as String?,
  year: (json['year'] as num?)?.toInt(),
  rating: (json['rating'] as num?)?.toInt(),
  runtime: (json['runtime'] as num?)?.toInt(),
  genres: (json['genres'] as List<dynamic>?)?.map((e) => e as String).toList(),
  likeCount: (json['like_count'] as num?)?.toInt(),
  descriptionIntro: json['description_intro'] as String?,
  descriptionFull: json['description_full'] as String?,
  ytTrailerCode: json['yt_trailer_code'] as String?,
  language: json['language'] as String?,
  mpaRating: json['mpa_rating'] as String?,
  backgroundImage: json['background_image'] as String?,
  backgroundImageOriginal: json['background_image_original'] as String?,
  smallCoverImage: json['small_cover_image'] as String?,
  mediumCoverImage: json['medium_cover_image'] as String?,
  largeCoverImage: json['large_cover_image'] as String?,
  mediumScreenshotImage1: json['medium_screenshot_image1'] as String?,
  mediumScreenshotImage2: json['medium_screenshot_image2'] as String?,
  mediumScreenshotImage3: json['medium_screenshot_image3'] as String?,
  largeScreenshotImage1: json['large_screenshot_image1'] as String?,
  largeScreenshotImage2: json['large_screenshot_image2'] as String?,
  largeScreenshotImage3: json['large_screenshot_image3'] as String?,
  cast: (json['cast'] as List<dynamic>?)
      ?.map((e) => CastDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  torrents: (json['torrents'] as List<dynamic>?)
      ?.map((e) => TorrentsDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  dateUploaded: json['date_uploaded'] as String?,
  dateUploadedUnix: (json['date_uploaded_unix'] as num?)?.toInt(),
);

Map<String, dynamic> _$MovieDetailsMovieDtoToJson(
  MovieDetailsMovieDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'url': instance.url,
  'imdb_code': instance.imdbCode,
  'title': instance.title,
  'title_english': instance.titleEnglish,
  'title_long': instance.titleLong,
  'slug': instance.slug,
  'year': instance.year,
  'rating': instance.rating,
  'runtime': instance.runtime,
  'genres': instance.genres,
  'like_count': instance.likeCount,
  'description_intro': instance.descriptionIntro,
  'description_full': instance.descriptionFull,
  'yt_trailer_code': instance.ytTrailerCode,
  'language': instance.language,
  'mpa_rating': instance.mpaRating,
  'background_image': instance.backgroundImage,
  'background_image_original': instance.backgroundImageOriginal,
  'small_cover_image': instance.smallCoverImage,
  'medium_cover_image': instance.mediumCoverImage,
  'large_cover_image': instance.largeCoverImage,
  'medium_screenshot_image1': instance.mediumScreenshotImage1,
  'medium_screenshot_image2': instance.mediumScreenshotImage2,
  'medium_screenshot_image3': instance.mediumScreenshotImage3,
  'large_screenshot_image1': instance.largeScreenshotImage1,
  'large_screenshot_image2': instance.largeScreenshotImage2,
  'large_screenshot_image3': instance.largeScreenshotImage3,
  'cast': instance.cast,
  'torrents': instance.torrents,
  'date_uploaded': instance.dateUploaded,
  'date_uploaded_unix': instance.dateUploadedUnix,
};
