import 'dart:io';

import 'package:themoviedb/domain/entity/movie.dart';
import 'package:themoviedb/extension/extension_httpclient.dart';

class MoviesApiClient {
  final _client = HttpClient();
  static const _host = 'https://api.themoviedb.org/3';
  static const _path = '/movie/popular';
  static const _imageUrl = 'https://image.tmdb.org/t/p/w500';
  static const _apiKey = '8060ec90419b19242da45c067a70a67e';
  static int page = 1;
  Map<String, dynamic> _getQueryParameters(String page) {
    final parameters = {'api_key': _apiKey, 'language': 'ru-RU', 'page': page};
    return parameters;
  }

  Future<PopularMoviePage> popularMovie() async {
    final parameters = _getQueryParameters('$page');
    final response =
        await _client.myGet(host: _host, path: _path, parameters: parameters);
    final json = await _client.myJsonDecode(response) as Map<String, dynamic>;
    final pages = await welcomeFromJson(json);
    print(pages);
    return pages;
  }
}
