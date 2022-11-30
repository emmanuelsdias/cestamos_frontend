import 'dart:core';
import '../../models/user.dart';
import '../../models/my_tuples.dart';
// import './base_urls_example.dart';
import './base_urls.dart';
import './request_factory.dart';

class UserHttpRequestHelper {
  static const String baseBackEndUserUrl = "${BaseUrls.baseBackEndUrl}/user/";

  static Future<Trio<User, bool, String>> createUser(
    String userName,
    String email,
    String password, {
    bool newUser = true,
  }) async {
    const String url = baseBackEndUserUrl;
    final body = {
      "username": userName,
      "email": email,
      "password": password,
      "new_user": newUser,
    };

    var response = await RequestFactory.post(url, body);

    var userData = response.content;
    User user;
    if (response.success) {
      user = User.fromJson(userData);
    } else {
      user = User();
    }

    return Trio(user, response.success, response.message);
  }

  static Future<Pair<User, bool>> logInUser(
      String email, String password) async {
    var response = await createUser("", email, password, newUser: false);

    return Pair(response.content, response.success);
  }
}
