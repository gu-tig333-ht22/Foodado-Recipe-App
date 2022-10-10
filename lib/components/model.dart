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
}
