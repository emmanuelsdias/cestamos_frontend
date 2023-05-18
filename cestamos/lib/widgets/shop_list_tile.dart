import 'package:flutter/material.dart';
import '../models/shop_list.dart';
import './helpers/flight_shuttle_builder.dart';

class ShopListTile extends StatelessWidget {
  const ShopListTile({Key? key, required this.shopListSummary}) : super(key: key);

  final ShopListSummary shopListSummary;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        child: ListTile(
          title: Hero(
            transitionOnUserGestures: true,
            tag: shopListSummary.id,
            flightShuttleBuilder: flightShuttleBuilder,
            child: Text(
              shopListSummary.shopListName,
              overflow: TextOverflow.clip,
              softWrap: false,
            ),
          ),
        ),
      ),
    );
  }
}
