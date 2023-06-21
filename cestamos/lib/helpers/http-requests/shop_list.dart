import 'dart:core';

import '../../models/item.dart';
import '../../models/friendship.dart';
import '../../models/shop_list.dart';
import '../../models/recipe.dart';
import '../../models/my_tuples.dart';
import '../../models/recipe.dart';
// import './base_urls_example.dart';
import './base_urls.dart';
import './request_factory.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShopListHttpRequestHelper {
  static const String baseBackEndShopListUrl = "${BaseUrls.baseBackEndUrl}/shop_list";

  static Future<Pair<List<ShopListSummary>, bool>> getLists() async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token') ?? "";
    var userId = prefs.getInt("user_id") ?? -1;
    final url = "$baseBackEndShopListUrl/?token=$token";
    var response = await RequestFactory.get(url);
    var listsData = response.listedContent;
    List<ShopListSummary> lists;
    if (response.success) {
      lists = listsData.map((i) => ShopListSummary.fromJson(i, userId)).toList();
    } else {
      lists = [];
    }
    return Pair(lists, response.success);
  }

  static Future<Pair<ShopList, bool>> getList(
    int shopListId,
  ) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token') ?? "";
    final url = "$baseBackEndShopListUrl/$shopListId?token=$token";
    var response = await RequestFactory.get(url);
    var listData = response.content;
    ShopList list;
    if (response.success) {
      list = ShopList.fromJson(listData);
    } else {
      list = ShopList();
    }
    return Pair(list, response.success);
  }

  static Future<Pair<ShopList, bool>> addItemToList(
    int shopListId,
    String name,
    String quantity,
  ) async {
    List<Item> items = [Item(name: name, quantity: quantity)];
    var response = await ShopListHttpRequestHelper.addItemsToList(shopListId, items);
    return response;
  }

  static Future<Pair<ShopList, bool>> addItemsToList(
    int shopListId,
    List<Item> items,
  ) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token') ?? "";
    final url = "$baseBackEndShopListUrl/$shopListId/item?token=$token";
    final body = items
        .map(
          (item) => {
            "name": item.name,
            "quantity": item.quantity,
          },
        )
        .toList();

    var response = await RequestFactory.post(url, body);
    var listData = response.content;
    ShopList list;

    if (response.success) {
      list = ShopList.fromJson(listData);
    } else {
      list = ShopList();
    }
    return Pair(list, response.success);
  }

  static Future<Pair<ShopList, bool>> createList(
    String listName,
    List<int> userIds,
  ) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token') ?? "";
    final url = "$baseBackEndShopListUrl/?token=$token";
    final body = {
      "name": listName,
      "user_ids": userIds,
      "is_template": false,
    };
    var response = await RequestFactory.post(url, body);
    var listData = response.content;
    ShopList list;

    if (response.success) {
      list = ShopList.fromJson(listData);
    } else {
      list = ShopList();
    }
    return Pair(list, response.success);
  }

  static Future<Pair<Friendship, bool>> addFriendtoList(
    int shopListId,
    int userId,
  ) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token') ?? "";
    final url = "$baseBackEndShopListUrl/$shopListId/user?token=$token";
    final body = [
      {
        "user_id": userId,
        "is_nutritionist": false,
      }
    ];
    var response = await RequestFactory.post(url, body);
    var friendData = response.content;
    Friendship friend;
    if (response.success) {
      friend = Friendship.fromJson(friendData);
    } else {
      friend = Friendship();
    }
    // TODO: fix friend -> List<UserList>
    return Pair(friend, response.success);
  }

  static Future<Pair<List<RecipeSummary>, bool>> getRecipesFromList(
    int shopListId,
  ) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token') ?? "";
    final url = "$baseBackEndShopListUrl/$shopListId/recipe?token=$token";
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

  static Future<Pair<RecipeSummary, bool>> addRecipeToList(
    int shopListId,
    int recipeId,
  ) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token') ?? "";
    final url = "$baseBackEndShopListUrl/$shopListId/recipe/$recipeId?token=$token";
    final Map<String, dynamic> body = {};

    var response = await RequestFactory.post(url, body);
    var recipeData = response.content;
    RecipeSummary recipe;

    if (response.success) {
      recipe = RecipeSummary.fromJson(recipeData);
    } else {
      recipe = RecipeSummary(
        id: 1,
        recipeName: "Receita Teste",
        description: "Uma receita testada e aprovada!",
        prepTime: "50",
        cookingTime: "15",
        restingTime: "5",
      );
    }
    return Pair(recipe, response.success);
  }

  static Future<Pair<RecipeSummary, bool>> removeRecipeFromList(
    int shopListId,
    int recipeId,
  ) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token') ?? "";
    final url = "$baseBackEndShopListUrl/$shopListId/recipe/$recipeId?token=$token";
    final Map<String, dynamic> body = {};

    var response = await RequestFactory.delete(url, body);
    var recipeData = response.content;
    RecipeSummary deletedRecipe;

    if (response.success) {
      deletedRecipe = RecipeSummary.fromJson(recipeData);
    } else {
      deletedRecipe = RecipeSummary(
        id: 1,
        recipeName: "Receita Teste",
        description: "Uma receita testada e aprovada!",
        prepTime: "50",
        cookingTime: "15",
        restingTime: "5",
      );
    }
    return Pair(deletedRecipe, response.success);
  }

  static Future<Pair<Recipe, bool>> getRecipeFromList(int shopListId, int recipeId) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token') ?? "";
    final url = "$baseBackEndShopListUrl/$shopListId/recipe/$recipeId/?token=$token";
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
}
