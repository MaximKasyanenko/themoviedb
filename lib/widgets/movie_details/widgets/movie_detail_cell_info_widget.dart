import 'package:flutter/material.dart';
import 'package:themoviedb/widgets/movie_details/models/movie_detail_model.dart';

class MovieDetailsInfoWidget extends StatelessWidget {
  const MovieDetailsInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _TopPostersWidget(),
        SizedBox(height: 10),
        _TitleWidget(),
        SizedBox(height: 10),
        _OverViewWidget(),
        SizedBox(height: 10),
        _SeriesCastWidget()
      ],
    );
  }
}

class _TopPostersWidget extends StatelessWidget {
  const _TopPostersWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = MovieDetailProvider.watch(context)!.model;

    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 200,
          child: Image.network(
            'https://image.tmdb.org/t/p/w500${model.movie?.backdropPath}',
            fit: BoxFit.fill,
          ),
        ),
        Positioned(
          top: 25,
          left: 10,
          bottom: 25,
          child: Image.network(
            'https://image.tmdb.org/t/p/w500${model.movie?.posterPath}',
            fit: BoxFit.fill,
            // width: 70,
            // height: 120,
          ),
        )
      ],
    );
  }
}

class _TitleWidget extends StatelessWidget {
  const _TitleWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final model = MovieDetailProvider.watch(context)?.model;
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            ('${model?.movie?.title} (${model?.movie?.releaseDate.year.toString()})'),
            maxLines: 3,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 19,
            ),
          ),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {},
                  child: Row(children: [
                    Container(
                      width: 40,
                      height: 40,
                      color: Colors.red,
                    ),
                    const SizedBox(width: 5),
                    const Text('Рейтинг')
                  ])),
              const SizedBox(width: 10),
              Container(
                color: Colors.grey,
                width: 2,
                height: 25,
              ),
              const SizedBox(width: 10),
              TextButton(
                  onPressed: () {},
                  child: Row(
                    children: const [
                      Icon(Icons.play_circle_outline),
                      Text('Возпроизвести'),
                    ],
                  ))
            ],
          ),
        )
      ],
    );
  }
}

class _OverViewWidget extends StatelessWidget {
  const _OverViewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = MovieDetailProvider.watch(context)?.model;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                const Text(
                  'Обзор',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 29,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  model?.movie?.overview ?? '',
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SeriesCastWidget extends StatelessWidget {
  const _SeriesCastWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'В главных ролях',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 23,
            ),
          ),
          SizedBox(
            height: 400,
            width: double.infinity,
            child: Scrollbar(
              trackVisibility: true,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10, //seriesCast.length,
                  itemBuilder: (BuildContext context, int index) {
                    return const _SeriesCastCellWidget();
                  }),
            ),
          ),
        ],
      ),
    );
  }
}

class _SeriesCastCellWidget extends StatelessWidget {
  const _SeriesCastCellWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(color: Colors.grey, blurRadius: 3, offset: Offset(1, 1)),
          ],
          border: Border.all(color: Colors.black.withOpacity(0.2), width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
              ),

              height: 100,
              // width: 100,
              // clipBehavior: Clip.hardEdge,
              child: Image.asset(
                'images/avatar.jpeg',
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
