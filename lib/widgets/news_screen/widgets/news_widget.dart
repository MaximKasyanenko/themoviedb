import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/widgets/news_screen/model/news_screen_model.dart';
import 'package:themoviedb/widgets/news_screen/widgets/new_trailer_widget/new_trailer_widget.dart';
import 'package:themoviedb/widgets/news_screen/widgets/trend_widget/trend_widget.dart';

class NewsWidget extends StatelessWidget {
  const NewsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<NewsScreenModel>().setupLocale(context);
    final popularMovie = context.watch<NewsScreenModel>().movie;
    return ListView(
      children: [
        TrendWidget(title: 'В тренде', movie: popularMovie),
        NewTrailerWidget(title: 'Новые трейлеры'),
        TrendWidget(title: 'Популярно', movie: popularMovie),
      ],
    );
  }
}
