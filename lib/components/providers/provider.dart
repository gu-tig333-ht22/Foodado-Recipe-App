import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:grupp_5/components/models/api_service.dart';
import 'package:grupp_5/components/models/filter_model.dart';

import 'package:http/http.dart' as http;

class RecipeProvider extends ChangeNotifier {
  FilterRecipe? _filterRecipe;
  FilterRecipe? get filterRecipe => _filterRecipe;
  String query = '';
  String type = '';
  String minCalories = '50';
  String maxCalories = '800';
  String maxReadyTime = '160';

  List<dynamic> dietaryRestrictions = [
    ['Vegan', false],
    ['Vegetarian', false],
    ['Gluten Free', false],
    ['Dairy Free', false],
    ['Nut Free', false],
    ['Egg Free', false],
    ['Soy Free', false],
    ['Fish Free', false],
  ];

  RecipeProvider() {
    fetchRecipe();
  }

  void fetchRecipe() async {
    final response = await http.get(Uri.parse(
        '$apiUrl/recipes/complexSearch?apiKey=$apiKey&query=$query&type=$type&addRecipeInformation=true&fillIngredients=true&number=1&minCalories=$minCalories&maxCalories=$maxCalories&offset=${Random().nextInt(20)}'));
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

  void setDietaryRestrictions(List dietaryRestrictions) {
    this.dietaryRestrictions = dietaryRestrictions;
    notifyListeners();
  }

  void clearfetchRecipe() {
    _filterRecipe = null;
    notifyListeners();
  }
}
