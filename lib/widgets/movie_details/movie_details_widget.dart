import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/widgets/movie_details/models/movie_detail_model.dart';
import 'package:themoviedb/widgets/movie_details/widgets/movie_detail_cell_info_widget.dart';

class MovieDetailsWidget extends StatelessWidget {
  const MovieDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<MovieDetailModel>();
    model.setupLocale(context);
    return Scaffold(
      appBar: AppBar(
        title: const _Title(),
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
            ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<MovieDetailModel>();
    return Text(model?.movie?.title ?? '');
  }
}
