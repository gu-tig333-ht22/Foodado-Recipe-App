import 'package:grupp_5/components/models/steps_model.dart';

final String tableRecipe = 'savedRecipes';

class RecipeFields {
  static final List<String> values = [
    /// Add all fields
    id, title, image, readyInMinutes, servings, summary, isFavorite, steps,
    extendedIngredients, ingredientDone
  ];
  static final String id = '_id';
  static final String title = 'title';
  static final String image = 'image';
  static final String readyInMinutes = 'readyInMinutes';
  static final String servings = 'servings';
  static final String summary = 'summary';
  static final String isFavorite = 'isFavorite';
  static final String ingredientDone = 'ingredientDone';
  static final String steps = 'steps';
  static final String extendedIngredients = 'extendedIngredients';
}

class Recipe {
  final int id;
  final String title;
  final String image;
  final int servings;
  final int readyInMinutes;
  final List<String> extendedIngredients;
  final String summary;
  final List<Steps> steps;
  final List<bool> ingredientDone;
  bool isFavorite;

  Recipe({
    required this.id,
    required this.title,
    required this.image,
    required this.readyInMinutes,
    required this.servings,
    required this.summary,
    required this.extendedIngredients,
    required this.steps,
    required this.ingredientDone,
    required this.isFavorite,
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
      ingredientDone:
          List<bool>.from(json['extendedIngredients'].map((x) => false)),
      //isfavourite id to false
      isFavorite: false,
    );
  }

  Map<String, Object?> toJson() => {
        RecipeFields.id: id,
        RecipeFields.title: title,
        RecipeFields.image: image,
        RecipeFields.readyInMinutes: readyInMinutes,
        RecipeFields.servings: servings,
        RecipeFields.summary: summary,
        RecipeFields.isFavorite: isFavorite ? 1 : 0,
        RecipeFields.steps: steps,
        RecipeFields.extendedIngredients: extendedIngredients,
      };

  Recipe copy({
    int? id,
    String? title,
    String? image,
    int? readyInMinutes,
    int? servings,
    String? summary,
    bool? isFavorite,
    List<Steps>? steps,
    List<String>? extendedIngredients,
  }) =>
      Recipe(
        id: id ?? this.id,
        title: title ?? this.title,
        image: image ?? this.image,
        readyInMinutes: readyInMinutes ?? this.readyInMinutes,
        servings: servings ?? this.servings,
        summary: summary ?? this.summary,
        extendedIngredients: extendedIngredients ?? this.extendedIngredients,
        steps: steps ?? this.steps,
        ingredientDone: ingredientDone,
        isFavorite: isFavorite ?? this.isFavorite,
      );

  static Recipe fromJsonDb(Map<String, Object?> json) => Recipe(
        id: json[RecipeFields.id] as int,
        title: json[RecipeFields.title] as String,
        image: json[RecipeFields.image] as String,
        readyInMinutes: json[RecipeFields.readyInMinutes] as int,
        servings: json[RecipeFields.servings] as int,
        summary: json[RecipeFields.summary] as String,
        isFavorite: json[RecipeFields.isFavorite] == 1,
        steps: json[RecipeFields.steps] as List<Steps>,
        ingredientDone: json[RecipeFields.extendedIngredients] as List<bool>,
        extendedIngredients:
            json[RecipeFields.extendedIngredients] as List<String>,
      );
}
