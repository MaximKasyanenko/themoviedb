import 'package:flutter/material.dart';
import 'package:themoviedb/domain/entity/movie.dart';
import 'package:themoviedb/domain/movies_api_client/movies_api_client.dart';

class MovieModel extends ChangeNotifier {
  final _client = MoviesApiClient();
  List<Movie> movie = [];

  loadMovies() async {
    final page = await _client.popularMovie();
    movie = page.results;

    notifyListeners();
  }
}

//MARK: -Inherited-
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
