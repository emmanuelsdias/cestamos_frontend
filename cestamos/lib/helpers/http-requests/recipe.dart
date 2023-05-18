import 'dart:core';

import './base_urls.dart';
import './request_factory.dart';
import '../../models/recipe.dart';
import '../../models/my_tuples.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecipeHttpRequestHelper {
  static const String baseBackEndItemUrl = "${BaseUrls.baseBackEndUrl}/recipe";

  static Future<Pair<List<RecipeSummary>, bool>> getRecipes(bool feed) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token') ?? "";
    final url = "$baseBackEndItemUrl/?token=$token&get_feed=$feed";
    var response = await RequestFactory.get(url);
    var recipesData = response.listedContent;
    List<RecipeSummary> recipes;
    if (response.success) {
      recipes = recipesData.map((i) => RecipeSummary.fromJson(i)).toList();
    } else {
      recipes = [];
    }
    return Pair(recipes, response.success);
  }

  static Future<Pair<Recipe, bool>> getRecipe(int recipeId) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token') ?? "";
    final url = "$baseBackEndItemUrl/$recipeId?token=$token";
    var response = await RequestFactory.get(url);
    var recipeData = response.content;
    Recipe recipe;
    if (response.success) {
      recipe = Recipe.fromJson(recipeData);
    } else {
      recipe = Recipe();
    }
    return Pair(recipe, response.success);
  }

  static Future<Pair<Recipe, bool>> createRecipe(Recipe recipe) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token') ?? "";
    final url = "$baseBackEndItemUrl/?token=$token";
    final body = {
      "name": recipe.recipeName,
      "description": recipe.description,
      "ingredients": recipe.ingredientsString,
      "people_served": recipe.peopleServed,
      "instructions": recipe.instructionsString,
      "prep_time": recipe.prepTime,
      "cooking_time": recipe.cookingTime,
      "resting_time": recipe.restingTime,
      "is_public": recipe.isPublic,
    };

    var response = await RequestFactory.post(url, body);
    var recipeData = response.content;
    Recipe createdRecipe;

    if (response.success) {
      createdRecipe = Recipe.fromJson(recipeData);
    } else {
      createdRecipe = Recipe();
    }
    return Pair(createdRecipe, response.success);
  }
}
