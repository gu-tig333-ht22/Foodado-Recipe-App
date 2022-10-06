import 'package:flutter/material.dart';
import '/constants/routes.dart';
import 'views/filter_view.dart';
import 'views/recipe_view.dart';
import 'views/scramble_view.dart';
import 'views/splash_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const SplashView(),
      debugShowCheckedModeBanner: false,
      routes: {
        splashViewRoute: (context) => const SplashView(),
        scrambleViewRoute: (context) => const ScrambleView(),
        filterViewRoute: (context) => const FilterView(),
        recipeViewRoute: (context) => const RecipeView(),
      },
    );
  }
}
