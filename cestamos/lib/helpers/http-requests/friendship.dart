import 'dart:core';
import '../../models/friendship.dart';
// import './base_urls_example.dart';
import './base_urls.dart';
import './request_factory.dart';
import '../../models/my_tuples.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FriendshipHttpRequestHelper {
  static const String baseBackEndFriendshipUrl =
      "${BaseUrls.baseBackEndUrl}/friendship";

  static Future<Pair<List<Friendship>, bool>> getFriendships() async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token') ?? "";
    final url = "$baseBackEndFriendshipUrl/?token=$token";
    var response = await RequestFactory.get(url);
    var friendshipsData = response.listedContent;
    List<Friendship> friendships;
    if (response.success) {
      friendships = friendshipsData.map((i) => Friendship.fromJson(i)).toList();
    } else {
      friendships = [];
    }
    return Pair(friendships, response.success);
  }

  static Future<Pair<Friendship, bool>> deleteFriendship(
      int friendshipId, int userId, String userName) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token') ?? "";
    final url = "$baseBackEndFriendshipUrl/$friendshipId?token=$token";
    final body = {
      "friendship_id": friendshipId,
      "user_id": userId,
    };

    var response = await RequestFactory.delete(url, body);
    var deletedFriendshipsData = response.content;
    Friendship deletedFriendship;
    if (response.success) {
      deletedFriendship = Friendship.fromJson(deletedFriendshipsData);
    } else {
      deletedFriendship = Friendship();
    }
    return Pair(deletedFriendship, response.success);
  }
}
