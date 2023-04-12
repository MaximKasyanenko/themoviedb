import 'package:flutter/material.dart';
import 'package:themoviedb/domain/entity/cast.dart';
import 'package:themoviedb/widgets/movie_details/models/movie_detail_model.dart';
import 'package:themoviedb/widgets/movie_trailer/movie_trailer_widget.dart';

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
  _showPlayer({required BuildContext context, required String trailerKey}) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            //height: MediaQuery.of(context).size.height * 0.5,
            child: MovieTrailerWidget(
              trailerKey: trailerKey,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = MovieDetailProvider.watch(context)?.model;
    final videos = model?.movie?.videos.results
        .where((video) => video.type == 'Trailer' && video.site == 'YouTube');
    final trailerKey = videos?.isNotEmpty == true ? videos?.first.key : null;
    return Column(
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
                  onPressed: trailerKey == null
                      ? null
                      : () {
                          _showPlayer(context: context, trailerKey: trailerKey);
                          // Navigator.pushNamed(
                          //   context,
                          //   MainNavigationRoutesName.movieTrailer,
                          //   arguments: trailerKey,
                          // );
                        },
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
    final model = MovieDetailProvider.watch(context)?.model;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            'В главных ролях',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 23,
            ),
          ),
        ),
        SizedBox(
          height: 320,
          width: double.infinity,
          child: Scrollbar(
            trackVisibility: true,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: model?.movie?.credits.cast.length,
                itemBuilder: (BuildContext context, int index) {
                  return _SeriesCastCellWidget(
                      cast: model?.movie?.credits.cast[index]);
                }),
          ),
        ),
      ],
    );
  }
}

class _SeriesCastCellWidget extends StatelessWidget {
  const _SeriesCastCellWidget({Key? key, required this.cast}) : super(key: key);
  final Cast? cast;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white38,
            boxShadow: const [
              BoxShadow(
                  color: Colors.grey, blurRadius: 3, offset: Offset(1, 1)),
            ],
            border: Border.all(color: Colors.black.withOpacity(0.2), width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),

                height: 200,
                width: 160,
                // clipBehavior: Clip.hardEdge,
                child: Image.network(
                  'https://image.tmdb.org/t/p/w500${cast?.profilePath}',
                  fit: BoxFit.fill,
                  loadingBuilder: (context, child, progress) {
                    return progress == null
                        ? child
                        : const Center(
                            child: CircularProgressIndicator(),
                          );
                  },
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    return const Icon(
                      Icons.person_outline_outlined,
                      size: 70,
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      cast?.name ?? '',
                      maxLines: 2,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      cast?.character ?? '',
                      maxLines: 3,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
