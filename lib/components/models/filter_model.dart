import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:grupp_5/components/models/api_service.dart';
import 'package:http/http.dart' as http;

class FilterRecipe {
  final List<RecipeOutput> results;

  FilterRecipe({
    required this.results,
  });

  factory FilterRecipe.fromJson(Map<String, dynamic> json) {
    return FilterRecipe(
      //from Recipe.fromJson
      results: List<RecipeOutput>.from(
          json['results'].map((x) => RecipeOutput.fromJson(x))),
    );
  }
}

class RecipeOutput {
  final int id;
  final String title;
  final String image;
  final int servings;
  final int readyInMinutes;
  final List<String> extendedIngredients;

  final String summary;

  const RecipeOutput({
    required this.id,
    required this.title,
    required this.image,
    required this.readyInMinutes,
    required this.servings,
    required this.extendedIngredients,
    required this.summary,
  });

  factory RecipeOutput.fromJson(Map<String, dynamic> json) {
    return RecipeOutput(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      image: json['image'] ?? '',
      readyInMinutes: json['readyInMinutes'] ?? 0,
      servings: json['servings'] ?? 0,
      extendedIngredients: List<String>.from(
          json['extendedIngredients'].map((x) => x['original'])),
      summary: json['summary'] ?? '',
    );
  }
}

String meat = 'meat';

Future<FilterRecipe> fetchFilterRecipe() async {
  final response = await http.get(Uri.parse(
      '$apiUrl/recipes/complexSearch?apiKey=$apiKey&query=$meat&addRecipeInformation=true&fillIngredients=true&number=2'));
  if (response.statusCode == 200) {
    return FilterRecipe.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load FilterRecipe');
  }
}
