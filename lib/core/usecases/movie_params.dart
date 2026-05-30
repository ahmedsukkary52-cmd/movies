class MovieParams {
  final int page;
  final String? genre;
  final String? query;
  final int? movieId;

  MovieParams({this.page = 1, this.genre, this.query, this.movieId});
}
