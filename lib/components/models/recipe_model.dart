import 'dart:async';
import 'dart:convert';
import 'package:grupp_5/components/models/api_service.dart';
import 'package:http/http.dart' as http;

class Recipe {
  final int id;
  final String title;
  final String image;
  final int servings;
  final int readyInMinutes;
  final List<String> extendedIngredients;
  final String summary;
  bool isFavourite;

  Recipe({
    required this.id,
    required this.title,
    required this.image,
    required this.readyInMinutes,
    required this.servings,
    required this.summary,
    required this.extendedIngredients,
    this.isFavourite = false,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      readyInMinutes: json['readyInMinutes'],
      servings: json['servings'],
      //todo: add amount and unit to map
      extendedIngredients: List<String>.from(
          json['extendedIngredients'].map((x) => x['original'])),

      summary: json['summary'],
      isFavourite: false,
    );
  }
}

Future<Recipe> fetchRecipe() async {
  final response = await http.get(Uri.parse(
      '$apiUrl/recipes/$apiId/information?apiKey=$apiKey&includeNutrition=false'));
  if (response.statusCode == 200) {
    return Recipe.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load Recipe');
  }
}




  //List of interesting api calls:
  // final int id;
  // final String title;
  // final String image;
  // final int servings;
  // final int readyInMinutes;
  // final bool cheap;
  // final bool vegetarian;
  // final bool vegan;
  // final bool glutenFree;
  // final bool dairyFree;
  // final bool veryHealthy;
  // final List<String> dishTypes;
  // final List<String> extendedIngredients;
  // final String summary;