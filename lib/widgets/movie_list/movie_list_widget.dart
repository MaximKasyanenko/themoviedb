import 'package:flutter/material.dart';
import 'package:themoviedb/services/navigation/navigation_service.dart';
import 'package:themoviedb/widgets/movie_list/models/movie_model.dart';
import 'models/movie.dart';

class MovieListWidget extends StatelessWidget {
  MovieListWidget({Key? key}) : super(key: key);
  final List<Movie> _movies = [];
  @override
  Widget build(BuildContext context) {
    final model = MovieProvider.watch(context)?.model;
    if (model == null) {
      return const Center(child: Text('Что-то пошло не так'));
    }
    return Stack(
      children: [
        ListView.builder(
            padding: const EdgeInsets.only(top: 70),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            itemCount: model.movie.length,
            itemExtent: 163,
            itemBuilder: (BuildContext context, int index) {
              return CellMovesWidget(
                  index: index + 1, movies: model.movie[index]);
            }),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Поиск',
              border: const OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white.withAlpha(230),
            ),
          ),
        )
      ],
    );
  }
}

class CellMovesWidget extends StatelessWidget {
  final int index;
  final Movie movies;

  const CellMovesWidget({
    required this.index,
    required this.movies,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(children: [
        Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black.withOpacity(0.2)),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              boxShadow: const [
                BoxShadow(
                    color: Colors.grey, blurRadius: 5, offset: Offset(0, 2))
              ]),
          child: Row(
            children: [
              Image.asset(movies.imageName),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  mainAxisAlignment: movies.description == ''
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      movies.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      movies.time,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    Text(
                      movies.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
        Positioned(
          right: 10,
          top: 10,
          child: Text('$index'),
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              Navigator.of(context).pushNamed(
                  MainNavigationRoutesName.movieDetails,
                  arguments: movies);
            },
          ),
        )
      ]),
    );
  }
}
