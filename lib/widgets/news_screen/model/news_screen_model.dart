import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:themoviedb/domain/entity/movie.dart';
import 'package:themoviedb/domain/movies_api_client/movies_api_client.dart';

class NewsScreenModel extends ChangeNotifier {
  final _client = MoviesApiClient();
  List<Movie> movie = [];
  var _locale = '';
  late DateFormat _dateFormat;

  setupLocale(BuildContext context) async {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale != locale) {
      _locale = locale;
      _dateFormat = DateFormat.yMMMMd(_locale);
      await loadMovies();
    }
  }

  loadMovies() async {
    try {
      final pages = await _client.popularMovie(locale: _locale);
      movie = pages.results;
    } on SocketException {
      Future.delayed(
          const Duration(seconds: 3), () async => await loadMovies());
    }
    notifyListeners();
  }

  String getDateToString(DateTime? date) {
    if (date != null) {
      return _dateFormat.format(date);
    }
    return '';
  }
}
