import 'package:grupp_5/components/models/steps_model.dart';

class Recipe {
  final int id;
  final String title;
  final String image;
  final int servings;
  final int readyInMinutes;
  final List<String> extendedIngredients;
  final String summary;
  //analyzedInstructions
  final List<Steps> steps;

  Recipe({
    required this.id,
    required this.title,
    required this.image,
    required this.readyInMinutes,
    required this.servings,
    required this.summary,
    required this.extendedIngredients,
    required this.steps,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      image: json['image'] ?? '',
      readyInMinutes: json['readyInMinutes'] ?? 0,
      servings: json['servings'] ?? 0,
      extendedIngredients: List<String>.from(
          json['extendedIngredients'].map((x) => x['original'])),
      summary: json['summary'] ?? '',
      steps: List<Steps>.from(json['analyzedInstructions'][0]['steps']
          .map((x) => Steps.fromJson(x))),
    );
  }
}
