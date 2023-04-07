import 'package:flutter/material.dart';
import 'package:themoviedb/services/navigation/navigation_service.dart';
import 'package:themoviedb/widgets/main_app_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final model = MainAppModel();
  await model.checkAuth();
  runApp(MyApp(model: model));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.model});
  final MainAppModel model;
  static final navigator = MainNavigation();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromRGBO(3, 37, 65, 1),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color.fromRGBO(3, 37, 65, 1),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
        ),
      ),
      routes: navigator.routes,
      initialRoute: navigator.initialRoutes(model.isAuth),
    );
  }
}
