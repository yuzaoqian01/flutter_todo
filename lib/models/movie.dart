class Movie {
  final String title;
  final String director;
  final String releaseDate;
  final String genre;
  final String posterUrl;

  Movie({
    required this.title,
    required this.director,
    required this.releaseDate,
    required this.genre,
    required this.posterUrl,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['title'],
      director: json['director'],
      releaseDate: json['release_date'],
      genre: json['genre'],
      posterUrl: json['poster_url'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'director': director,
      'release_date': releaseDate,
      'genre': genre,
      'poster_url': posterUrl,
    };
  }
}