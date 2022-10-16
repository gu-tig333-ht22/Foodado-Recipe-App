import 'package:flutter/material.dart';
import 'package:grupp_5/components/models/recipe_model.dart';
import 'package:grupp_5/components/models/steps_model.dart';
import 'package:grupp_5/views/dev_view.dart';
import 'package:grupp_5/views/save_view.dart';
import 'package:provider/provider.dart';
import '/constants/routes.dart';
import 'views/filter_view.dart';

import 'views/recipe_view.dart';
import 'views/scramble_view.dart';
import 'views/info_view.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RecipeProvider()),
        ChangeNotifierProvider(
            create: (context) => AnalyzedInstructionProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          textTheme: GoogleFonts.montserratTextTheme(),
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
        },
      ),
    ),
  );
}
