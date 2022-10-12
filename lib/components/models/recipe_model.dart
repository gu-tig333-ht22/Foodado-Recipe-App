import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

//apoonacular apikey
String apiKey = "e65a6aed8a9a49f0a49400eebe646ec5";
String apiUrl = "https://api.spoonacular.com";

int apiId = 716430;

Future<Recipe> fetchRecipe() async {
  final response = await http.get(Uri.parse(
      '$apiUrl/recipes/$apiId/information?apiKey=$apiKey&includeNutrition=false'));
  if (response.statusCode == 200) {
    return Recipe.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load Recipe');
  }
}

class Recipe {
  final int id;
  final String title;
  final String image;
  final int servings;
  final int readyInMinutes;
  final List<String> extendedIngredients;

  final String summary;

  const Recipe({
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
      id: json['id'],
      title: json['title'],
      image: json['image'],
      readyInMinutes: json['readyInMinutes'],
      servings: json['servings'],
      //todo: add amount and unit to map
      extendedIngredients:
          List<String>.from(json['extendedIngredients'].map((x) => x['name'])),

      summary: json['summary'],
    );
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