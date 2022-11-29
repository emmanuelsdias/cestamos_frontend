import './item.dart';
import './user.dart';

class ShopList {
  int id;
  String shopListName;
  List<Item> items;
  List<UserList> users;
  ShopList({
    this.id = 0,
    this.shopListName = "",
    this.items = const [],
    this.users = const [],
  });

  factory ShopList.fromJson(Map<String, dynamic> json) {
    return ShopList(
      id: json['shop_list_id'] as int,
      shopListName: json['name'] as String,
      items: (json['items'] as List).map((e) => Item.fromJson(e)).toList(),
      users: (json['user_lists'] as List)
          .map((e) => UserList.fromJson(e))
          .toList(),
    );
  }
}

class ShopListSummary {
  int id;
  String shopListName;

  ShopListSummary({
    required this.id,
    required this.shopListName,
  });

  factory ShopListSummary.fromJson(Map<String, dynamic> json) {
    return ShopListSummary(
      id: json['shop_list_id'] as int,
      shopListName: json['name'] as String,
    );
  }
}
