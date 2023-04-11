import 'package:flutter/material.dart';
import 'package:themoviedb/widgets/movie_details/models/movie_detail_model.dart';
import 'package:themoviedb/widgets/movie_details/widgets/movie_detail_cell_info_widget.dart';
import 'package:themoviedb/widgets/movie_list/models/movie_model.dart';

class MovieDetailsWidget extends StatefulWidget {
  const MovieDetailsWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<MovieDetailsWidget> createState() => _MovieDetailsWidgetState();
}

class _MovieDetailsWidgetState extends State<MovieDetailsWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final model = MovieDetailProvider.watch(context)?.model;
    model?.setupLocale(context);
  }

  @override
  Widget build(BuildContext context) {
    final model = MovieDetailProvider.watch(context)?.model;
    model?.setupLocale(context);
    return Scaffold(
        appBar: AppBar(
          title: _Title(),
          centerTitle: true,
        ),
        body: model?.movie == null
            ? const Center(child: CircularProgressIndicator())
            : ColoredBox(
                color: const Color.fromRGBO(47, 76, 124, 1.0),
                child: ListView(
                  children: const [
                    MovieDetailsInfoWidget(),
                  ],
                ),
              ));
  }
}

class _Title extends StatelessWidget {
  const _Title({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = MovieDetailProvider.watch(context)?.model;
    return Text(model?.movie?.title ?? 'fd');
  }
}
