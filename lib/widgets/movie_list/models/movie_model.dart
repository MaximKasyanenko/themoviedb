import 'package:flutter/material.dart';
import 'package:themoviedb/widgets/movie_list/models/movie.dart';

class MovieModel extends ChangeNotifier {
  List<Movie> movie = [
    Movie(
        id: 5,
        imageName: 'images/avatar.jpeg',
        title: 'Avatar',
        time: 'April 7, 2021',
        description: '')
  ];

  push(BuildContext context) async {
    // notifyListeners();
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
