import 'dart:core';

import './base_urls.dart';
import './request_factory.dart';
import '../../models/item.dart';
import '../../models/my_tuples.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemHttpRequestHelper {
  static const String baseBackEndItemUrl = "${BaseUrls.baseBackEndUrl}/item";

  static Future<Pair<Item, bool>> editItem(Item item) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token') ?? "";
    final url = "$baseBackEndItemUrl/${item.itemId}?token=$token";
    var body = {
      "item_id": item.itemId,
      "name": item.name,
      "quantity": item.quantity,
      "was_bought": item.wasBought,
    };
    var response = await RequestFactory.put(url, body);
    var itemData = response.content;
    Item newItem;
    if (response.success) {
      newItem = Item.fromJson(itemData);
    } else {
      newItem = Item();
    }
    return Pair(newItem, response.success);
  }

  static Future<Pair<Item, bool>> deleteItem(Item item) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token') ?? "";
    final url = "$baseBackEndItemUrl/${item.itemId}?token=$token";
    var response = await RequestFactory.delete(url, {});
    var itemData = response.content;
    Item newItem;
    if (response.success) {
      newItem = Item.fromJson(itemData);
    } else {
      newItem = Item();
    }
    return Pair(newItem, response.success);
  }
}
