import 'package:grupp_5/components/models/recipe_model.dart';

class SavedRecipe {
  final List<Recipe> results;

  SavedRecipe({
    required this.results,
  });

  factory SavedRecipe.fromJson(Map<String, dynamic> json) {
    return SavedRecipe(
      results:
          List<Recipe>.from(json['results'].map((x) => Recipe.fromJson(x))),
    );
  }
}
