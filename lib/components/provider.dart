import 'package:flutter/material.dart';
import 'model.dart';
import 'package:provider/provider.dart';

//recipestate from model.dart
class RecipeState extends ChangeNotifier {
  final List<Recipe> _recipes = <Recipe>[
    Recipe(
      id: 716429,
      title: 'Pasta with Garlic, Scallions, Cauliflower & Breadcrumbs',
      image: 'https://spoonacular.com/recipeImages/716429-556x370.jpg',
      readyInMinutes: 45,
      servings: 4,
      cheap: false,
      vegetarian: false,
      vegan: false,
      glutenFree: false,
      dairyFree: false,
      veryHealthy: false,
      dishTypes: ["lunch", "main course", "main dish", "dinner"],
      summary: 'This is a summary',
      extendedIngredients: [
        '1 tablespoon olive oil',
        '1 onion, diced',
        '2 carrots, diced',
        '2 celery sticks, diced',
        '2 garlic cloves, crushed',
        '500g lean beef mince',
        '1 x 400g can chopped tomatoes',
        '1 beef stock cube',
        '1 tablespoon tomato purée',
        '1 tablespoon dried oregano',
        '1 tablespoon dried basil',
        '1 tablespoon dried parsley',
        '400g spaghetti',
        '50g parmesan, grated, plus extra to serve',
        '1 tablespoon chopped parsley, to serve',
      ],
    ),
  ];
  List<Recipe> get recipes => _recipes;
}
