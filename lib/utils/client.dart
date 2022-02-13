import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:paymeback/auth/provider.dart';

class Client {
  final auth = AuthProvider();

  Future<Map<String, dynamic>> handleResponse(response) async {
    if (response.statusCode == 401) {
      await auth.logout();
      return throw Exception({'message': 'Please re-authenticate.'});
    }
    final data = await jsonDecode(response.body);
    if ((response.statusCode ~/ 100) == 2) {
      return data;
    } else {
      return throw Exception(data);
    }
  }

  final String? apiURL = dotenv.env['APP_AUTH_URL'];

  Future<Map<String, dynamic>> get(
      String endpoint, Map<String, dynamic>? queryParams) async {
    final String? token = await auth.getToken();

    Map<String, String>? headers = {'Content-Type': 'application/json'};
    if (token != null) {
      headers['Authorization'] = token;
    }

    return await http
        .get(
            Uri.https("api-paymeback.herokuapp.com", "/api/v1/$endpoint",
                queryParams),
            headers: headers)
        .then(handleResponse);
  }

  Future<Map<String, dynamic>> post(
      String endpoint, Map<String, dynamic> data) async {
    final String? token = await auth.getToken();

    Map<String, String>? headers = {'Content-Type': 'application/json'};
    if (token != null) {
      headers['Authorization'] = token;
    }

    return await http
        .post(Uri.parse('$apiURL/$endpoint/'),
            headers: headers, body: jsonEncode(data))
        .then(handleResponse);
  }

  Future<Map<String, dynamic>> delete(
      String endpoint, Map<String, dynamic> data) async {
    final String? token = await auth.getToken();

    Map<String, String>? headers = {'Content-Type': 'application/json'};
    if (token != null) {
      headers['Authorization'] = token;
    }

    return await http
        .delete(Uri.parse('$apiURL/$endpoint/'),
            headers: headers, body: jsonEncode(data))
        .then(handleResponse);
  }

  Future<Map<String, dynamic>> patch(
      String endpoint, Map<String, dynamic> data) async {
    final String? token = await auth.getToken();

    Map<String, String>? headers = {'Content-Type': 'application/json'};
    if (token != null) {
      headers['Authorization'] = token;
    }

    return await http
        .patch(Uri.parse('$apiURL/$endpoint/'),
            headers: headers, body: jsonEncode(data))
        .then(handleResponse);
  }
}
