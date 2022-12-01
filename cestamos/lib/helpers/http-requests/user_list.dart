import 'dart:core';
import '../../models/user.dart';
import '../../models/my_tuples.dart';
// import './base_urls_example.dart';
import './base_urls.dart';
import './request_factory.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserListHttpRequestHelper {
  static const String baseBackEndUserListUrl =
      "${BaseUrls.baseBackEndUrl}/user_list";

  static Future<Pair<UserList, bool>> deleteUserList(
    int userListId,
  ) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token') ?? "";
    final url = "$baseBackEndUserListUrl/$userListId?token=$token";
    var response = await RequestFactory.delete(url, {});
    var userListData = response.content;
    UserList userList;
    if (response.success) {
      userList = UserList.fromJson(userListData);
    } else {
      userList = UserList();
    }
    return Pair(userList, response.success);
  }

  static Future<Pair<UserList, bool>> changeUserStatus(
    int userListId,
    bool shouldBecomeAdm,
  ) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token') ?? "";
    final url = "$baseBackEndUserListUrl/$userListId?token=$token";
    var body = {
      "is_adm": shouldBecomeAdm,
      "is_nutritionist": false,
    };
    var response = await RequestFactory.put(url, body);
    var userListData = response.content;
    UserList userList;
    if (response.success) {
      userList = UserList.fromJson(userListData);
    } else {
      userList = UserList();
    }
    return Pair(userList, response.success);
  }
}
