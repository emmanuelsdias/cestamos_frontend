import 'dart:core';
import '../../models/friendship.dart';
import './base_urls_example.dart';
// import './base_urls.dart';
import './request_factory.dart';

class FriendshipHttpRequestHelper {
  static const String baseBackEndUserUrl =
      "${BaseUrls.baseBackEndUrl}/friendship/";

  static Future<List<Friendship>> getUsers() async {
    var friendshipsData = await RequestFactory.get(baseBackEndUserUrl);
    var friendships =
        (friendshipsData as List).map((i) => Friendship.fromJson(i)).toList();
    return friendships;
  }
}
