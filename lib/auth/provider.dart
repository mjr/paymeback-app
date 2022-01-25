import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'user.dart';

extension IsOk on http.Response {
  bool get ok {
    return (statusCode ~/ 100) == 2;
  }
}

const String localStorageKey = '__auth_provider_token__';
final String authorizationCredentials = 'Basic ${base64Encode(utf8.encode(
  "${dotenv.env['PUBLIC_CLIENT_ID_PRIVATE']}:${dotenv.env['PUBLIC_CLIENT_SECRET_PRIVATE']}"
))}';

class AuthProvider {
  User? _user;

  User get user => _user!;
  final _storage = new FlutterSecureStorage();

  void setUser(BuildContext context, User? user) {
    if (user != null) {
      saveUser(user);
      _user = user;
      Navigator.pushReplacementNamed(context, 'home', arguments: user);
    } else {
      logout();
      _user = null;
      Navigator.pushReplacementNamed(context, 'login');
    }
  }

  Future<void> saveUser(User user) async {
    await _storage.write(key: 'user', value: user.toJson());
  }

  Future<void> currentUser(BuildContext context) async {
    await Future.delayed(Duration(seconds: 2));
    String? jsonUser = await _storage.read(key: 'user');
    if (jsonUser != null) {
      setUser(context, User.fromJson(jsonUser));
      return;
    } else {
      setUser(context, null);
    }
  }

  Future<Map<String, dynamic>> handleUserResponse(Map<String, dynamic> data) async {
    await _storage.write(key: localStorageKey, value: data['user']['token']);
    return data['user'];
  }

  Future<Map<String, dynamic>> login(String? username, String? password) async {
    return client(
      'login',
      { 'username': username, 'password': password }
    ).then(handleUserResponse);
  }

  Future<Map<String, dynamic>> register(String? fullName, String? username, String? password) async {
    return client(
      'register',
      {'fullName': fullName, 'username': username, 'password': password }
    ).then(handleUserResponse);
  }

  Future<void> logout() async {
    await _storage.delete(key: localStorageKey);
    await _storage.delete(key: 'user');
  }

  final String? authURL = dotenv.env['APP_AUTH_URL'];

  Future<Map<String, dynamic>> client(String endpoint, Map<String, dynamic> data) async {
    return await http.post(
      Uri.parse('${authURL}/${endpoint}/'),
      body: jsonEncode(data),
      headers: { 'Authorization': authorizationCredentials, 'Content-Type': 'application/json' },
    ).then((response) async {
      final data = await jsonDecode(response.body);
      if (response.ok) {
        return data;
      } else {
        return throw Exception(data);
      }
    });
  }
}
