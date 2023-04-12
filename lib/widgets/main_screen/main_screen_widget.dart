import 'package:flutter/material.dart';
import 'package:themoviedb/domain/data_provider/session_data_provider.dart';
import 'package:themoviedb/services/navigation/navigation_service.dart';
import 'package:themoviedb/widgets/movie_list/models/movie_model.dart';
import 'package:themoviedb/widgets/movie_list/movie_list_widget.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  int _selectedPage = 0;
  final List<String> _titles = const ['Новости', 'Фильмы', 'Сериали'];
  void _selectTap(int index) {
    if (_selectedPage == index) return;
    setState(() {
      _selectedPage = index;
    });
  }

  final movieModel = MovieModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    movieModel.setupLocale(context);
    movieModel.loadMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              SessionDataProvider().setSessionId(null);
              Navigator.pushReplacementNamed(
                  context, MainNavigationRoutesName.auth);
            },
            icon: const Icon(Icons.assignment_ind_outlined),
          )
        ],
        title: Text(_titles[_selectedPage]),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPage,
        onTap: _selectTap,
        items: [
          BottomNavigationBarItem(
              icon: const Icon(Icons.home), label: _titles[0]),
          BottomNavigationBarItem(
              icon: const Icon(Icons.movie), label: _titles[1]),
          BottomNavigationBarItem(
              icon: const Icon(Icons.tv), label: _titles[2]),
        ],
      ),
      body: IndexedStack(index: _selectedPage, children: [
        MovieProvider(model: movieModel, child: const MovieListWidget()),
        MovieProvider(model: movieModel, child: const MovieListWidget()),
        MovieProvider(model: movieModel, child: const MovieListWidget()),
      ]),
    );
  }
}
