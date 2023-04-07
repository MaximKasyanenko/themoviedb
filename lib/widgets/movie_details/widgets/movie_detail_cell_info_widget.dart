import 'package:flutter/material.dart';
import 'package:themoviedb/widgets/movie_details/models/series_cast.dart';

class MovieDetailsInfoWidget extends StatelessWidget {
  final List<SeriesCast> seriesCast = [];
  MovieDetailsInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _TopPostersWidget(),
        const SizedBox(height: 10),
        const _TitleWidget(),
        const SizedBox(height: 10),
        const _OverViewWidget(),
        const SizedBox(height: 10),
        _SeriesCastWidget(seriesCast: seriesCast)
      ],
    );
  }
}

class _TopPostersWidget extends StatelessWidget {
  const _TopPostersWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 200,
          child: Image.asset(
            'images/avatar.jpeg',
            fit: BoxFit.fill,
          ),
        ),
        Positioned(
          top: 25,
          left: 10,
          bottom: 25,
          child: Image.asset('images/avatar.jpeg'),
        )
      ],
    );
  }
}

class _TitleWidget extends StatelessWidget {
  const _TitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Expanded(
                  child: Text(
                'Avatarhghhghghghhghghghhghghghghhghghghhghghghghhghghghhg',
                maxLines: 3,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                ),
              ))
            ],
          ),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Row(
            children: [
              Expanded(
                child: TextButton(
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
              ),
              const SizedBox(width: 10),
              Container(
                color: Colors.grey,
                width: 2,
                height: 25,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextButton(
                    onPressed: () {},
                    child: Row(
                      children: const [
                        Icon(Icons.play_circle_outline),
                        Text('Возпроизвести'),
                        SizedBox(height: 40)
                      ],
                    )),
              )
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: const [
                Text(
                  'Обзор',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 29,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'После принятия образа аватара солдат Джейк Салли становится предводителем народа нави и берет на себя миссию по защите новых друзей от корыстных бизнесменов с Земли. Теперь ему есть за кого бороться — с Джейком его прекрасная возлюбленная Нейтири. Когда на Пандору возвращаются до зубов вооруженные земляне, Джейк готов дать им отпор.',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'После принятия образа аватара солдат Джейк Салли становится предводителем народа нави и берет на себя миссию по защите новых друзей от корыстных бизнесменов с Земли. Теперь ему есть за кого бороться — с Джейком его прекрасная возлюбленная Нейтири. Когда на Пандору возвращаются до зубов вооруженные земляне, Джейк готов дать им отпор.',
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SeriesCastWidget extends StatelessWidget {
  final List<SeriesCast> seriesCast;

  const _SeriesCastWidget({Key? key, required this.seriesCast})
      : super(key: key);

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
            BoxShadow(color: Colors.grey, blurRadius: 10, offset: Offset(1, 1)),
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
