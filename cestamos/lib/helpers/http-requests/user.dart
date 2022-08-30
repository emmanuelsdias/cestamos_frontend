import 'dart:core';
import '../../models/user.dart';
import './base_urls.dart';
import './request_factory.dart';

class UserHttpRequestHelper {
  static const String baseBackEndUserUrl = "${BaseUrls.baseBackEndUrl}/user/";

  static Future<List<User>> getUsers() async {
    var usersData = await RequestFactory.get(baseBackEndUserUrl);
    var users = (usersData as List).map((i) => User.fromJson(i)).toList();
    return users;
  }
}
