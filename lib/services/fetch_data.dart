import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_app/models/movies.dart';
import '../models/movies.dart';
import '../models/genre_model.dart';
import '../models/tvshow_model.dart';

class FetchMovies {
  final _apikey = '3d5765c960c283fc0c2356912a73a6d2';

  //Popular Movie Model
  Future<List<Movies>> fetchPopularMovies() async {
    {
      final response = await http.get(
          Uri.parse(
              'https://api.themoviedb.org/3/movie/popular?api_key=$_apikey&language=en-US'),
          headers: {
            "Accept": "application/json",
            "Access-Control-Allow-Origin": "*",
          });

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        // List<Movie>
        var movieData = data['results'].cast<Map<String, dynamic>>();
        return movieData
            .map<Movies>((json) => Movies.fromJson(json))
            .toList();
        // var json = response.body;
        // return movieFromJson(json);
      } else {
        throw Exception('Failed to load Data');
      }
    }
  }

  //Top Movie Fetch
  Future<List<Movies>> fetchTopMovies() async {
    final response = await http.get(
        Uri.parse(
            'https://api.themoviedb.org/3/movie/top_rated?api_key=$_apikey&language=en-US'),
        headers: {
          "Accept": "application/json",
          "Access-Control-Allow-Origin": "*",
        });

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      // List<Movie>
      var movieData = data['results'].cast<Map<String, dynamic>>();
      return movieData
          .map<Movies>((json) => Movies.fromJson(json))
          .toList();
      // var json = response.body;
      // return movieFromJson(json);
    } else {
      throw Exception('Failed to load Data');
    }
  }

  Future<List<Movies>> fetchUpcomingMovies() async {
    final response = await http.get(
        Uri.parse(
            'https://api.themoviedb.org/3/movie/upcoming?api_key=$_apikey&language=en-US'),
        headers: {
          "Accept": "application/json",
          "Access-Control-Allow-Origin": "*",
        });

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      // List<Movie>
      var movieData = data['results'].cast<Map<String, dynamic>>();
      return movieData
          .map<Movies>((json) => Movies.fromJson(json))
          .toList();
      // var json = response.body;
      // return movieFromJson(json);
    } else {
      throw Exception('Failed to load Data');
    }
  }

  Future<List<Genre>> fetchGenre() async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/genre/movie/list?api_key=$_apikey&language=en-US&page=1'));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      // List<Movie>
      var genreData = data['genres'].cast<Map<String, dynamic>>();
      return genreData.map<Genre>((json) => Genre.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load Data');
    }
  }

  // Future<List<Movies>> searchMovies() async {

  //   final response = await http.get(Uri.parse(
  //       'https://api.themoviedb.org/3/search/multi?api_key=$_apikey&query=avengers'));

  //   if (response.statusCode == 200) {
  //     var data = json.decode(response.body);
  //     // List<Movie>
  //     var result = data['results'].cast<Map<String, dynamic>>();
  //     return result.map<Movies>((json) => Movies.fromJson(json)).toList();
  //   } else {
  //     throw Exception('Failed to load Data');
  //   }
  // }

  Future<List<TvShow>> getTvShows() async {
    final response = await http.get(
        Uri.parse(
            'https://api.themoviedb.org/3/tv/popular?api_key=3d5765c960c283fc0c2356912a73a6d2&language=en-US&page=1'),
        headers: {
          "Accept": "application/json",
          "Access-Control-Allow-Origin": "*",
        });

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      // List<Movie>
      var tvShowData = data['results'].cast<Map<String, dynamic>>();
      return tvShowData.map<TvShow>((json) => TvShow.fromJson(json)).toList();
      // var json = response.body;
      // return movieFromJson(json);
    } else {
      throw Exception('Failed to load Data');
    }
  }
}
