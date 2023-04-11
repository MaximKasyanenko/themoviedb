import 'dart:io';

import 'package:themoviedb/domain/entity/movie.dart';
import 'package:themoviedb/domain/entity/movie_details.dart';
import 'package:themoviedb/extension/extension_httpclient.dart';

class MoviesApiClient {
  final _client = HttpClient();
  static const _host = 'https://api.themoviedb.org/3';
  static const _pathPopular = '/movie/popular';
  static const _pathDetail = '/movie/';
  static const _imageUrl = 'https://image.tmdb.org/t/p/w500';
  static const _apiKey = '8060ec90419b19242da45c067a70a67e';
  static const _pathSearch = '/search/movie';
// movie list
  Future<PopularMoviePage> popularMovie(
      {required String locale, int page = 1}) async {
    final response =
        await _client.myGet(host: _host, path: _pathPopular, parameters: {
      'api_key': _apiKey,
      'language': locale,
      'page': '$page',
    });
    final json = await _client.myJsonDecode(response) as Map<String, dynamic>;
    final pages = await welcomeFromJson(json);
    return pages;
  }

// movie list
  Future<PopularMoviePage> searchMovie(
      {required String locale, required String query}) async {
    final response =
        await _client.myGet(host: _host, path: _pathSearch, parameters: {
      'api_key': _apiKey,
      'language': locale,
      'query': query,
    });
    final json = await _client.myJsonDecode(response) as Map<String, dynamic>;
    final pages = await welcomeFromJson(json);
    return pages;
  }

  // movie detail
  Future<MoviesDetail> getDetailMovies(
      {required String locale, required int id}) async {
    final response =
        await _client.myGet(host: _host, path: '$_pathDetail$id', parameters: {
      'api_key': _apiKey,
      'language': locale,
    });
    final json = await _client.myJsonDecode(response) as Map<String, dynamic>;
    final movie = moviesDetailFromJson(json);
    return movie;
  }
}
