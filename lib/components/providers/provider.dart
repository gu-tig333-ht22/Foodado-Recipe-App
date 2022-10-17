import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:grupp_5/components/models/api_service.dart';
import 'package:grupp_5/components/models/filter_model.dart';
import 'package:grupp_5/components/models/recipe_model.dart';
import 'package:grupp_5/components/models/steps_model.dart';
import 'package:http/http.dart' as http;

class RecipeProvider extends ChangeNotifier {
  Recipe? _recipe;
  Recipe? get recipe => _recipe;
  AnalyzedInstruction? _analyzedInstruction;
  AnalyzedInstruction? get analyzedInstruction => _analyzedInstruction;
  FilterRecipe? _filterRecipe;
  FilterRecipe? get filterRecipe => _filterRecipe;
  String query = '';
  String type = '';

  RecipeProvider() {
    fetchRecipe();
    fetchAnalyzedInstruction();
    fetchFilterRecipe();
  }

  void fetchRecipe() async {
    final response = await http.get(Uri.parse(
        '$apiUrl/recipes/$apiId/information?apiKey=$apiKey&includeNutrition=false'));
    if (response.statusCode == 200) {
      _recipe = Recipe.fromJson(jsonDecode(response.body));
      notifyListeners();
    } else if (response.statusCode == 404) {
      apiId = Random().nextInt(5000);
      fetchRecipe();
    } else {
      throw Exception('Failed to load Recipe');
    }
  }

  void fetchAnalyzedInstruction() async {
    final response = await http.get(Uri.parse(
        '$apiUrl/recipes/$apiId/analyzedInstructions?apiKey=$apiKey&stepBreakdown=true'));
    if (response.statusCode == 200) {
      _analyzedInstruction =
          AnalyzedInstruction.fromJson(jsonDecode(response.body)[0]);
      notifyListeners();
    } else {
      throw Exception('Failed to load AnalyzedInstruction');
    }
  }

  void fetchFilterRecipe() async {
    final response = await http.get(Uri.parse(
        '$apiUrl/recipes/complexSearch?apiKey=$apiKey&query=$query&type=$type&addRecipeInformation=true&fillIngredients=true&number=1'));
    if (response.statusCode == 200) {
      _filterRecipe = FilterRecipe.fromJson(jsonDecode(response.body));
      notifyListeners();
    } else {
      throw Exception('Failed to load FilterRecipe');
    }
  }
}
