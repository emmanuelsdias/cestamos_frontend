import 'package:flutter/material.dart';
import '../models/friendship.dart';

class Friendships with ChangeNotifier {
  List<Friendship> _friendships = [];

  List<Friendship> get friendships {
    return [..._friendships];
  }

  void addFriendship(Friendship friendship) {
    _friendships.add(friendship);
    notifyListeners();
  }

  void setFriendshipList(List<Friendship> friendships) {
    _friendships = [...friendships];
    notifyListeners();
  }
}
