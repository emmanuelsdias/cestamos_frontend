import 'dart:core';
import '../../models/user.dart';
import '../../models/my_tuples.dart';
// import './base_urls_example.dart';
import './base_urls.dart';
import './request_factory.dart';

class UserHttpRequestHelper {
  static const String baseBackEndUserUrl = "${BaseUrls.baseBackEndUrl}/user/";

  static Future<Pair<User, bool>> createUser(
      String userName, String email, String password) async {
    const String url = baseBackEndUserUrl;
    final body = {
      "username": userName,
      "email": email,
      "password": password,
    };
    var response = await RequestFactory.post(url, body);
    var userData = response.content;
    User user;
    if (response.code == 200) {
      user = User.fromJson(userData);
    } else {
      user = User();
    }
    return Pair(user, response.code == 200);
  }

  static Future<Pair<User, bool>> logInUser(
      String email, String password) async {
    return await createUser("", email, password);
  }
}
