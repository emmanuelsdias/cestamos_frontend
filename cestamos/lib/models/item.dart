class Item {
  Item({
    this.itemId = 0,
    this.name = "",
    this.quantity = "",
    this.wasBought = false,
  });

  final int itemId;
  final String name;
  final String quantity;
  bool wasBought;

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      itemId: json['item_id'] as int,
      name: json['name'] as String,
      quantity: json['quantity'] as String,
      wasBought: json['was_bought'] as bool,
    );
  }
}
