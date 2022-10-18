import 'package:grupp_5/components/models/steps_model.dart';

class Recipe {
  final int id;
  final String title;
  final String image;
  final int servings;
  final int readyInMinutes;
  final List<String> extendedIngredients;
  final String summary;
  final List<AnalyzedInstruction> analyzedInstructions;

  Recipe({
    required this.id,
    required this.title,
    required this.image,
    required this.readyInMinutes,
    required this.servings,
    required this.summary,
    required this.extendedIngredients,
    required this.analyzedInstructions,
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
      analyzedInstructions: List<AnalyzedInstruction>.from(
          json['analyzedInstructions']
              .map((x) => AnalyzedInstruction.fromJson(x))),
    );
  }
}
