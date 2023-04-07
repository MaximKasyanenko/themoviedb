import 'package:flutter/material.dart';
import 'package:themoviedb/widgets/movie_details/widgets/movie_detail_cell_info_widget.dart';

import '../../domain/entity/movie.dart';

class MovieDetailsWidget extends StatefulWidget {
  const MovieDetailsWidget({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final Movie movie;
  @override
  State<MovieDetailsWidget> createState() => _MovieDetailsWidgetState();
}

class _MovieDetailsWidgetState extends State<MovieDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.movie.title),
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
