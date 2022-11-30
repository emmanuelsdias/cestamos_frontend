import 'dart:core';
import '../../models/shop_list.dart';
import '../../models/my_tuples.dart';
// import './base_urls_example.dart';
import './base_urls.dart';
import './request_factory.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShopListHttpRequestHelper {
  static const String baseBackEndShopListUrl =
      "${BaseUrls.baseBackEndUrl}/shop_list";

  static Future<Pair<List<ShopListSummary>, bool>> getLists() async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token') ?? "";
    final url = "$baseBackEndShopListUrl/?token=$token";
    var response = await RequestFactory.get(url);
    var listsData = response.listedContent;
    List<ShopListSummary> lists;
    if (response.success) {
      lists = listsData.map((i) => ShopListSummary.fromJson(i)).toList();
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
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token') ?? "";
    final url = "$baseBackEndShopListUrl/$shopListId/item?token=$token";
    final body = {
      "name": name,
      "quantity": quantity,
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
}
