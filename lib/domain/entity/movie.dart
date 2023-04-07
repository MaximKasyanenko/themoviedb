// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Future<PopularMoviePage> welcomeFromJson(Map<String, dynamic> str) async =>
    PopularMoviePage.fromJson(str);

String welcomeToJson(PopularMoviePage data) => json.encode(data.toJson());

class PopularMoviePage {
  PopularMoviePage({
    required this.page,
    required this.results,
    required this.totalResults,
    required this.totalPages,
  });

  int page;
  List<Movie> results;
  int totalResults;
  int totalPages;

  factory PopularMoviePage.fromJson(Map<String, dynamic> json) =>
      PopularMoviePage(
        page: json["page"],
        results:
            List<Movie>.from(json["results"].map((x) => Movie.fromJson(x))),
        totalResults: json["total_results"],
        totalPages: json["total_pages"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_results": totalResults,
        "total_pages": totalPages,
      };
}

class Movie {
  Movie({
    required this.posterPath,
    required this.adult,
    required this.overview,
    required this.releaseDate,
    required this.genreIds,
    required this.id,
    required this.originalTitle,
    required this.title,
    required this.backdropPath,
    required this.popularity,
    required this.voteCount,
    required this.video,
    required this.voteAverage,
  });

  String? posterPath;
  bool adult;
  String overview;
  // @JsonKey(fromJson: _repleaseDateFromString)
  DateTime? releaseDate;
  List<int> genreIds;
  int id;
  String originalTitle;
  String title;
  String? backdropPath;
  double popularity;
  int voteCount;
  bool video;
  double voteAverage;

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        posterPath: json["poster_path"],
        adult: json["adult"],
        overview: json["overview"],
        releaseDate: DateTime.parse(json["release_date"]),
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originalTitle: json["original_title"],
        title: json["title"],
        backdropPath: json["backdrop_path"],
        popularity: json["popularity"]?.toDouble(),
        voteCount: json["vote_count"],
        video: json["video"],
        voteAverage: json["vote_average"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "poster_path": posterPath,
        "adult": adult,
        "overview": overview,
        "release_date":
            "${releaseDate?.year.toString().padLeft(4, '0')}-${releaseDate?.month.toString().padLeft(2, '0')}-${releaseDate?.day.toString().padLeft(2, '0')}",
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "id": id,
        "original_title": originalTitle,
        "title": title,
        "backdrop_path": backdropPath,
        "popularity": popularity,
        "vote_count": voteCount,
        "video": video,
        "vote_average": voteAverage,
      };
}
