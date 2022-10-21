import 'package:flutter/material.dart';
import 'package:grupp_5/components/providers/provider.dart';
import 'package:grupp_5/views/dev_view.dart';
import 'package:grupp_5/views/intro_view.dart';
import 'package:grupp_5/views/save_view.dart';
import 'package:provider/provider.dart';
import '/constants/routes.dart';
import 'views/filter_view.dart';
import 'views/recipe_view.dart';
import 'views/scramble_view.dart';
import 'views/info_view.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RecipeProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          textTheme: GoogleFonts.montserratTextTheme(),
          scaffoldBackgroundColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        home: const DevView(),
        routes: {
          devViewRoute: (context) => const DevView(),
          infoViewRoute: (context) => const InfoView(),
          scrambleViewRoute: (context) => const ScrambleView(),
          filterViewRoute: (context) => const FilterView(),
          recipeViewRoute: (context) => const RecipeView(),
          saveViewRoute: (context) => const SaveView(),
          introViewRoute: (context) => const IntroView(),
        },
      ),
    ),
  );
}
