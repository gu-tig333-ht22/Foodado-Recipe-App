import 'dart:async';
import 'dart:convert';
import 'dart:math';
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

  Recipe({
    required this.id,
    required this.title,
    required this.image,
    required this.readyInMinutes,
    required this.servings,
    required this.summary,
    required this.extendedIngredients,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      image: json['image'] ?? '',
      readyInMinutes: json['readyInMinutes'] ?? 0,
      servings: json['servings'] ?? 0,
      //todo: add amount and unit to map
      extendedIngredients: List<String>.from(
          json['extendedIngredients'].map((x) => x['original'])),

      summary: json['summary'] ?? '',
    );
  }
}

Future<Recipe> fetchRecipe() async {
  final response = await http.get(Uri.parse(
      '$apiUrl/recipes/$apiId/information?apiKey=$apiKey&includeNutrition=false'));
  if (response.statusCode == 200) {
    return Recipe.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 404) {
    apiId = Random().nextInt(5000);
    return fetchRecipe();
  } else {
    throw Exception('Failed to load Recipe');
  }
}

//return user filter to add to url
