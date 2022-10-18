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
  FilterRecipe? _filterRecipe;
  FilterRecipe? get filterRecipe => _filterRecipe;
  String query = '';
  String type = '';

  RecipeProvider() {
    fetchRecipe();
  }

  void fetchRecipe() async {
    final response = await http.get(Uri.parse(
        '$apiUrl/recipes/complexSearch?apiKey=$apiKey&query=$query&type=$type&addRecipeInformation=true&fillIngredients=true&number=1&offset=${Random().nextInt(20)}'));
    if (response.statusCode == 200) {
      _filterRecipe = FilterRecipe.fromJson(jsonDecode(response.body));
      notifyListeners();
    } else if (response.statusCode == 404) {
      fetchRecipe();
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
}
