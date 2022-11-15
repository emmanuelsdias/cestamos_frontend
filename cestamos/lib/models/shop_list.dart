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
