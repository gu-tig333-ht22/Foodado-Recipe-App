import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:grupp_5/components/models/api_service.dart';
import 'package:grupp_5/components/models/filter_model.dart';
import 'package:grupp_5/components/models/recipe_model.dart';
import 'package:grupp_5/components/db/preferences_service.dart';

import 'package:http/http.dart' as http;

class RecipeProvider extends ChangeNotifier {
  FilterRecipe? _filterRecipe;
  FilterRecipe? get filterRecipe => _filterRecipe;
  Recipe? _savedRecipe;
  Recipe? get savedRecipe => _savedRecipe;
  String recipeId = '';
  String query = '';
  String type = '';
  String diet = '';
  String minCalories = '50';
  String maxCalories = '800';
  String maxReadyTime = '160';

  // RecipeProvider() {
  //   fetchRecipe();
  // }
  //$apiUrl/recipes/complexSearch?apiKey=$apiKey&query=$query&type=$type&diet=$diet&addRecipeInformation=true&instructionsRequired=true&fillIngredients=true&number=10&minCalories=$minCalories&maxCalories=$maxCalories&offset=${Random().nextInt(20)}

  Future fetchRecipe() async {
    final response = await http.get(Uri.parse(
        '$apiUrl/recipes/complexSearch?apiKey=$apiKey&query=$query&type=$type&diet=$diet&addRecipeInformation=true&instructionsRequired=true&fillIngredients=true&number=10&minCalories=$minCalories&maxCalories=$maxCalories&maxReadyTime=$maxReadyTime&offset=${Random().nextInt(20)}'));
    if (response.statusCode == 200) {
      _filterRecipe = FilterRecipe.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);

      notifyListeners();
    } else if (response.statusCode == 404) {
      throw Exception('Recipe not found');
    } else {
      throw Exception('Failed to load Recipe');
    }
  }

  Future getSavedRecipe() async {
    final response = await http.get(Uri.parse(
        '$apiUrl/recipes/$recipeId/information?apiKey=$apiKey&addRecipeInformation=true&instructionsRequired=true&fillIngredients=true&number=1'));
    if (response.statusCode == 200) {
      _savedRecipe = Recipe.fromJson(jsonDecode(response.body));
      notifyListeners();
    } else if (response.statusCode == 404) {
      throw Exception('Recipe not found, recipe id: $recipeId');
    } else {
      throw Exception('Failed to load Recipe');
    }
  }

  void setRecipeType(String type) {
    this.type = type;

    notifyListeners();
  }

  void setRecipeQuery(String query) {
    this.query = query;
    notifyListeners();
  }

  void setDiet(String diet) {
    this.diet = diet;

    notifyListeners();
  }

  void setRecipeId(String recipeId) async {
    this.recipeId = recipeId;
    notifyListeners();
  }

  void clearFilters() {
    query = '';
    type = '';
    minCalories = '50';
    maxCalories = '800';
    maxReadyTime = '160';
    diet = '';

    notifyListeners();
  }

  nextRecipe() {
    filterRecipe!.results.removeAt(0);
    notifyListeners();
  }
}
