import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:themoviedb/domain/entity/movie.dart';
import 'package:themoviedb/domain/movies_api_client/movies_api_client.dart';

class MovieModel extends ChangeNotifier {
  final _client = MoviesApiClient();
  List<Movie> movie = [];
  late DateFormat _dateFormat;
  var _locale = '';
  var _currentPage = 1;
  var _maxPage = 1;
  var _isSearch = false;

  searchMoviesOfName({required String query}) async {
    final pageMovie = await _client.searchMovie(locale: _locale, query: query);
    movie = pageMovie.results;
    _isSearch = true;
    notifyListeners();
  }

//пагинация
  showMoviesAtIndex() async {
    if (_currentPage <= _maxPage && !_isSearch) {
      _currentPage += 1;
      await loadMovies();
      notifyListeners();
    } else {
      return;
    }
  }

  String getDateToString(DateTime? date) {
    if (date != null) {
      return _dateFormat.format(date);
    }
    return '';
  }

  setupLocale(BuildContext context) {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale != locale) {
      _locale = locale;
      _dateFormat = DateFormat.yMMMMd(_locale);
    }
  }

  loadMovies() async {
    if (_isSearch) {
      movie.clear();
      _isSearch = false;
    }
    try {
      final pages =
          await _client.popularMovie(locale: _locale, page: _currentPage);
      movie += pages.results;
      _maxPage = pages.totalPages;
    } on SocketException {
      Future.delayed(
          const Duration(seconds: 3), () async => await loadMovies());
      // await loadMovies();
    }
    notifyListeners();
  }
}

//MARK: Inherited
class MovieProvider extends InheritedNotifier {
  final MovieModel model;
  const MovieProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(key: key, child: child, notifier: model);

  static MovieProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MovieProvider>();
  }

  static MovieProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<MovieProvider>()
        ?.widget;
    return widget is MovieProvider ? widget : null;
  }
}
