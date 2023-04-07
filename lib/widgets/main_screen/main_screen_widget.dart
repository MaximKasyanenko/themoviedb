import 'package:flutter/material.dart';
import 'package:themoviedb/domain/data_provider/session_data_provider.dart';
import 'package:themoviedb/widgets/movie_list/models/movie_model.dart';
import 'package:themoviedb/widgets/movie_list/movie_list_widget.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  int _selectedPage = 0;
  void _selectTap(int index) {
    if (_selectedPage == index) return;
    setState(() {
      _selectedPage = index;
    });
  }

  final movieModel = MovieModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              SessionDataProvider().setSessionId(null);
            },
            icon: const Icon(Icons.assignment_ind_outlined),
          )
        ],
        title: const Text('TMDB'),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPage,
        onTap: _selectTap,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Новости'),
          BottomNavigationBarItem(icon: Icon(Icons.movie), label: 'Фильмы'),
          BottomNavigationBarItem(icon: Icon(Icons.tv), label: 'Сериали'),
        ],
      ),
      body: IndexedStack(index: _selectedPage, children: [
        const Text('Index 0: Новости'),
        MovieProvider(model: movieModel, child: MovieListWidget()),
        const Text('Index 2: Сериали'),
      ]),
    );
  }
}
