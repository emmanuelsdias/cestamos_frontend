import 'dart:core';

import './base_urls.dart';
import './request_factory.dart';
import '../../models/recipe.dart';
import '../../models/my_tuples.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecipeHttpRequestHelper {
  static const String baseBackEndItemUrl = "${BaseUrls.baseBackEndUrl}/recipe";

  static Future<Pair<List<RecipeSummary>, bool>> getRecipes(bool getFeed) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token') ?? "";
    final url = "$baseBackEndItemUrl/?token=$token&get_feed=$getFeed";
    var response = await RequestFactory.get(url);
    var recipeSummariesData = response.listedContent;
    List<RecipeSummary> recipes;
    if (response.success) {
      recipes = recipeSummariesData.map((x) => RecipeSummary.fromJson(x)).toList();
    } else {
      recipes = [];
    }
    return Pair(recipes, response.success);
  }

  static Future<Pair<List<RecipeSummary>, bool>> getUserRecipes() async {
    return getRecipes(false);
  }
  static Future<Pair<List<RecipeSummary>, bool>> getFriendsRecipes(bool getFeed) async {
    return getRecipes(true);
  }

}
