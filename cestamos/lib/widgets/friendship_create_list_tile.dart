import 'package:flutter/material.dart';
import '../models/friendship.dart';

class FriendshipCreateListTile extends StatelessWidget {
  const FriendshipCreateListTile({Key? key, required this.friendship})
      : super(key: key);

  final Friendship friendship;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        color: Theme.of(context).colorScheme.primary,
        child: ListTile(
          title: Text(
            friendship.username,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
