import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:grupp_5/components/models/api_service.dart';
import 'package:grupp_5/components/models/recipe_model.dart';
import 'package:http/http.dart' as http;

import 'filter_data.dart';

class FilterRecipe {
  final List<Recipe> results;

  FilterRecipe({
    required this.results,
  });

  factory FilterRecipe.fromJson(Map<String, dynamic> json) {
    return FilterRecipe(
      results:
          List<Recipe>.from(json['results'].map((x) => Recipe.fromJson(x))),
    );
  }
}

Future<FilterRecipe> fetchFilterRecipe() async {
  final response = await http.get(Uri.parse(
      '$apiUrl/recipes/complexSearch?apiKey=$apiKey&query=$query&type=$type&addRecipeInformation=true&fillIngredients=true&number=1'));
  if (response.statusCode == 200) {
    return FilterRecipe.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load FilterRecipe');
  }
}
