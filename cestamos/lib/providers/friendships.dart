import 'package:flutter/material.dart';
import '../models/friendship.dart';

class Friendships with ChangeNotifier {
  List<Friendship> _friendships = [
    Friendship(
      friendshipId: 1,
      userId: 1,
      username: "Gandhi",
    ),
    Friendship(
      friendshipId: 2,
      userId: 2,
      username: "Educado",
    ),
    Friendship(
      friendshipId: 3,
      userId: 3,
      username: "MM",
    ),
  ];

  List<Friendship> get friendships {
    return [..._friendships];
  }

  void addFriendship(Friendship friendship) {
    _friendships.add(friendship);
    notifyListeners();
  }
}
