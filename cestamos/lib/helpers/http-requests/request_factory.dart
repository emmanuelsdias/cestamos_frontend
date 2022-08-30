import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:core';

class RequestFactory {
  static Future<dynamic> get(String url) async {
    var response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data;
    } else {
      return null;
    }
  }
}
