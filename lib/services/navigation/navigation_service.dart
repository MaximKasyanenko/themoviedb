import 'package:flutter/cupertino.dart';
import 'package:themoviedb/widgets/auth/auth_widget.dart';
import 'package:themoviedb/widgets/auth/model/auth_model.dart';
import 'package:themoviedb/widgets/main_screen/main_screen_widget.dart';
import 'package:themoviedb/widgets/movie_details/movie_details_widjet.dart';
import 'package:themoviedb/widgets/movie_list/models/movie.dart';

class MainNavigationRoutesName {
  static const auth = 'auth';
  static const mainScreen = '/';
  static const movieDetails = '/movie_details';
}

class MainNavigation {
  String initialRoutes(bool isAuth) => isAuth
      ? MainNavigationRoutesName.mainScreen
      : MainNavigationRoutesName.auth;

  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRoutesName.auth: (context) =>
        AuthProvider(model: AuthModel(), child: const AuthWidget()),
    MainNavigationRoutesName.mainScreen: (context) => const MainScreenWidget(),
    MainNavigationRoutesName.movieDetails: (context) {
      final movieId = ModalRoute.of(context)!.settings.arguments as Movie;
      return MovieDetailsWidget(movieId: movieId);
    }
  };
}
