import 'package:flutter/material.dart';
import 'package:themoviedb/domain/entity/movie.dart';
import 'package:themoviedb/widgets/news_screen/widgets/trend_widget/trend_widget_cell.dart';

// ignore: must_be_immutable
class TrendWidget extends StatefulWidget {
  TrendWidget({Key? key, required this.title, required this.movie})
      : super(key: key);
  final String title;
  List<Movie>? movie;
  @override
  State<TrendWidget> createState() => _TrendWidgetState();
}

class _TrendWidgetState extends State<TrendWidget> {
  @override
  Widget build(BuildContext context) {
    final movies = widget.movie;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  widget.title,
                  style: const TextStyle(fontSize: 27),
                ),
              ),
              ElevatedButton(onPressed: () {}, child: const Text('сегодня')),
              const SizedBox(
                width: 30,
              )
            ],
          ),
        ),
        SizedBox(
          height: 350,
          child: Scrollbar(
            trackVisibility: true,
            child: movies!.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: movies.length,
                    itemBuilder: (BuildContext context, int index) {
                      return TrendCellWidget(movie: movies[index]);
                    },
                  ),
          ),
        ),
      ],
    );
  }
}
