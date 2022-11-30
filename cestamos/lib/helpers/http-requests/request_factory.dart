import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:core';
import '../../models/my_tuples.dart';

class RequestFactory {
  static final encoding = Encoding.getByName('utf-8');
  static final headers = {'Content-Type': 'application/json'};

  static RequestResponse convert(http.Response response) {
    var result = RequestResponse({}, [], 0);
    result.code = response.statusCode;

    var data = json.decode(utf8.decode(response.bodyBytes));
    if (data is List) {
      result.listedContent = data;
    } else {
      result.content = data;
    }
    return result;
  }

  static Future<RequestResponse> get(String url) async {
    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );
    return convert(response);
  }

  static Future<RequestResponse> post(String url, dynamic body) async {
    final jsonBody = json.encode(body);
    var response = await http.post(
      Uri.parse(url),
      body: jsonBody,
      encoding: encoding,
      headers: headers,
    );
    return convert(response);
  }

  static Future<RequestResponse> put(
      String url, Map<String, dynamic> body) async {
    final jsonBody = json.encode(body);
    var response = await http.put(
      Uri.parse(url),
      body: jsonBody,
      encoding: encoding,
      headers: headers,
    );
    return convert(response);
  }

  static Future<RequestResponse> delete(
      String url, Map<String, dynamic> body) async {
    final jsonBody = json.encode(body);
    var response = await http.delete(
      Uri.parse(url),
      body: jsonBody,
      encoding: encoding,
      headers: headers,
    );
    return convert(response);
  }
}
