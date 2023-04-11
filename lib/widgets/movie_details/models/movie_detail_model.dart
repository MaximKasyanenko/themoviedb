import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:themoviedb/domain/entity/movie_details.dart';
import 'package:themoviedb/domain/movies_api_client/movies_api_client.dart';

class MovieDetailModel extends ChangeNotifier {
  MoviesDetail? movie;
  final int movieId;
  final _client = MoviesApiClient();
  late DateFormat _dateFormat;
  var _locale = '';

  MovieDetailModel(this.movieId);

  getDetailMovies() async {
    movie = await _client.getDetailMovies(locale: _locale, id: movieId);
    notifyListeners();
  }

  setupLocale(BuildContext context) async {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale != locale) {
      _locale = locale;
      _dateFormat = DateFormat.yMMMMd(_locale);
    }
    await getDetailMovies();
  }
}

class MovieDetailProvider extends InheritedNotifier {
  final MovieDetailModel model;
  const MovieDetailProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(key: key, child: child, notifier: model);

  static MovieDetailProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MovieDetailProvider>();
  }

  static MovieDetailProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<MovieDetailProvider>()
        ?.widget;
    return widget is MovieDetailProvider ? widget : null;
  }
}
