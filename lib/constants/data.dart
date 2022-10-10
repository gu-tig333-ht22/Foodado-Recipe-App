class Recipe {
  final int id;
  final String title;
  final String image;
  final int servings;
  final int readyInMinutes;
  final bool cheap;
  final bool vegetarian;
  final bool vegan;
  final bool glutenFree;
  final bool dairyFree;
  final bool veryHealthy;
  final List<String> dishTypes;
  final List<String> extendedIngredients;
  final String summary;

  Recipe({
    required this.id,
    required this.title,
    required this.image,
    required this.readyInMinutes,
    required this.servings,
    required this.cheap,
    required this.vegetarian,
    required this.vegan,
    required this.glutenFree,
    required this.dairyFree,
    required this.veryHealthy,
    required this.dishTypes,
    required this.extendedIngredients,
    required this.summary,
  });

  List<Recipe> recipes = [
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
      summary: 'This is a summary',
    ),
  ];
}
