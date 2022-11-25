import 'package:flutter/material.dart';
import '../models/shop_list.dart';

class ShopListTile extends StatelessWidget {
  const ShopListTile({Key? key, required this.shopListSummary})
      : super(key: key);

  final ShopListSummary shopListSummary;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(shopListSummary.shopListName),
    );
  }
}
