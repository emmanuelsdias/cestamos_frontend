import 'package:flutter/material.dart';
import '../models/friendship.dart';

class FriendshipTile extends StatelessWidget {
  const FriendshipTile({Key? key, required this.friendship}) : super(key: key);

  final Friendship friendship;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(friendship.username),
    );
  }
}
