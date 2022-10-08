import 'package:flutter/material.dart';
import '/constants/routes.dart';
import 'views/filter_view.dart';
import 'views/recipe_view.dart';
import 'views/scramble_view.dart';
import 'views/splash_view.dart';
//google fonts
import 'package:google_fonts/google_fonts.dart';

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
        textTheme: //googlefonts
            GoogleFonts.robotoTextTheme(Theme.of(context).textTheme),
      ),
      home: const MainView(),
      debugShowCheckedModeBanner: false,
      routes: {
        mainViewRoute: (context) => const MainView(),
        infoViewRoute: (context) => const InfoView(),
        scrambleViewRoute: (context) => const ScrambleView(),
        filterViewRoute: (context) => const FilterView(),
        recipeViewRoute: (context) => const RecipeView(),
      },
    );
  }
}

//Navigation during development
class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Development View',
          ),
        ),
      ),
      body: Center(
        //buttons to navigate to other views
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(infoViewRoute);
              },
              child: Text('Info View'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(scrambleViewRoute);
              },
              child: Text('Scramble View'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(recipeViewRoute);
              },
              child: Text('Recipe View'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(filterViewRoute);
              },
              child: Text('Filter View'),
            ),
          ],
        ),
      ),
    );
  }
}
