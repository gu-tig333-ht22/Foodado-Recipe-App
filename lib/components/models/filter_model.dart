import 'package:grupp_5/components/models/recipe_model.dart';

class FilterRecipe {
  final List<Recipe> results;

  FilterRecipe({
    required this.results,
  });

  factory FilterRecipe.fromJson(Map<String, dynamic> json) {
    return FilterRecipe(
      results: List<Recipe>.from(
          json['results'].map((x) => Recipe.fromJson(x)).toList()),
    );
  }
}

class FilterSettings {
  final double maxCal;
  final double minCal;
  final double maxReadyTime;

  FilterSettings({
    required this.maxCal,
    required this.minCal,
    required this.maxReadyTime,
  });
}
