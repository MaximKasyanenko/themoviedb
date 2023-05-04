import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/domain/entity/movie.dart';
import 'package:themoviedb/services/navigation/navigation_service.dart';
import 'package:themoviedb/widgets/news_screen/model/news_screen_model.dart';

class TrendCellWidget extends StatelessWidget {
  const TrendCellWidget({Key? key, required this.movie}) : super(key: key);
  final Movie movie;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final model = context.read<NewsScreenModel>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: (screenSize.width - 32) / 2,
        // color: Colors.grey,
        child: Column(
          children: [
            Container(
              height: 280,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white38, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Stack(children: [
                Image.network(
                  'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                  fit: BoxFit.fill,
                  height: 280,
                  loadingBuilder: (context, child, progress) {
                    return progress == null
                        ? child
                        : const Center(
                            child: CircularProgressIndicator(),
                          );
                  },
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    return const Center(
                      child: Icon(Icons.error_outline, size: 50),
                    );
                  },
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      Navigator.of(context).pushNamed(
                          MainNavigationRoutesName.movieDetails,
                          arguments: movie.id);
                    },
                  ),
                )
              ]),
            ),
            Text(
              movie.title,
              maxLines: 2,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            Expanded(child: Text(model.getDateToString(movie.releaseDate)))
          ],
        ),
      ),
    );
  }
}
