import 'package:flutter/material.dart';
import 'package:themoviedb/widgets/movie_details/widgets/movie_detail_cell_info_widget.dart';

import '../movie_list/models/movie.dart';

class MovieDetailsWidget extends StatefulWidget {
  const MovieDetailsWidget({
    Key? key,
    required this.movieId,
  }) : super(key: key);

  final Movie movieId;
  @override
  State<MovieDetailsWidget> createState() => _MovieDetailsWidgetState();
}

class _MovieDetailsWidgetState extends State<MovieDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.movieId.title),
          centerTitle: true,
        ),
        body: ColoredBox(
          color: const Color.fromRGBO(168, 188, 224, 1.0),
          child: ListView(
            children: [
              MovieDetailsInfoWidget(),
            ],
          ),
        ));
  }
}
