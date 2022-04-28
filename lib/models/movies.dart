import 'dart:convert';

Movies moviesFromJson(String str) => Movies.fromJson(json.decode(str));

String moviesToJson(Movies data) => json.encode(data.toJson());

class Movies {
  Movies({
    required this.adult,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
    required this.popularity,
    required this.mediaType,
  });

  bool adult;
  List<int> genreIds;
  int id;
  String originalLanguage;
  String overview;
  String posterPath;
  String releaseDate;
  String title;
  bool video;
  double voteAverage;
  int voteCount;
  double popularity;
  String mediaType;

  factory Movies.fromJson(Map<String, dynamic> json) => Movies(
        adult: json["adult"] ?? false,
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originalLanguage: json["original_language"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        releaseDate: json["release_date"]?? 'None',
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
        popularity: json["popularity"].toDouble(),
        mediaType: json["media_type"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "id": id,
        "original_language": originalLanguage,
        "overview": overview,
        "poster_path": posterPath,
        "release_date":releaseDate,
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "popularity": popularity,
        "media_type": mediaType,
      };
}
