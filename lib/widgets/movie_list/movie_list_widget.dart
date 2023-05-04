import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/services/navigation/navigation_service.dart';
import 'package:themoviedb/widgets/movie_list/models/movie_model.dart';
import '../../domain/entity/movie.dart';

class MovieListWidget extends StatefulWidget {
  const MovieListWidget({Key? key}) : super(key: key);

  @override
  State<MovieListWidget> createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {
  @override
  Widget build(BuildContext context) {
    final model = context.watch<MovieModel>();
    return Stack(
      children: [
        model.movie.isEmpty
            ? model.isSearchEmpty()
                ? const Center(child: Text('Нет результатов'))
                : const Center(child: CircularProgressIndicator())
            : ListView.builder(
                padding: const EdgeInsets.only(top: 70),
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                itemCount: model.movie.length,
                itemExtent: 180,
                itemBuilder: (BuildContext context, int index) {
                  if (index == model.movie.length - 2) {
                    model.showMoviesAtIndex();
                  }
                  return CellMovesWidget(
                      index: index + 1, movies: model.movie[index]);
                }),
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: SearchFieldWidget(),
        )
      ],
    );
  }
}

class SearchFieldWidget extends StatefulWidget {
  const SearchFieldWidget({
    super.key,
  });
  @override
  State<SearchFieldWidget> createState() => _SearchFieldWidgetState();
}

class _SearchFieldWidgetState extends State<SearchFieldWidget> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  bool _showClearButton = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
    _focusNode.addListener(_onFocusChanged);
  }

  void _onTextChanged() {
    setState(() {
      _showClearButton = _controller.text.isNotEmpty;
    });
  }

  void _onFocusChanged() {
    setState(() {
      _showClearButton = _focusNode.hasFocus || _controller.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = context.read<MovieModel>();
    return TextField(
      focusNode: _focusNode,
      controller: _controller,
      textInputAction: TextInputAction.search,
      textCapitalization: TextCapitalization.words,
      onSubmitted: (value) {
        if (value != '') {
          model.searchMoviesOfName(query: value.toLowerCase());
        }
      },
      decoration: InputDecoration(
        suffixIcon: _showClearButton
            ? IconButton(
                onPressed: () {
                  _controller.clear();
                  FocusScope.of(context).unfocus();
                  model.loadMovies();
                },
                icon: const Icon(Icons.cancel),
              )
            : null,
        labelText: 'Поиск',
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: Colors.white.withAlpha(230),
      ),
    );
  }
}

class CellMovesWidget extends StatelessWidget {
  final int index;
  final Movie movies;

  const CellMovesWidget({
    required this.index,
    required this.movies,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final posterPath = movies.posterPath;
    final model = context.read<MovieModel>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(children: [
        Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black.withOpacity(0.2)),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              boxShadow: const [
                BoxShadow(
                    color: Colors.grey, blurRadius: 5, offset: Offset(-1, 2))
              ]),
          child: Row(
            children: [
              SizedBox(
                width: 105,
                height: 180,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w500$posterPath',
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
                      return const Center(
                        child: Icon(Icons.error_outline, size: 50),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  mainAxisAlignment: movies.overview == ''
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      movies.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      model.getDateToString(movies.releaseDate),
                      style: const TextStyle(color: Colors.grey),
                    ),
                    Text(
                      movies.overview,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
        Positioned(
          right: 10,
          top: 10,
          child: Text('$index'),
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              Navigator.of(context).pushNamed(
                  MainNavigationRoutesName.movieDetails,
                  arguments: movies.id);
            },
          ),
        )
      ]),
    );
  }
}
