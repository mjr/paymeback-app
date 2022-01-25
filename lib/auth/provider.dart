import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'user.dart';

class AuthProvider {
  User? _user;

  User get user => _user!;

  void setUser(BuildContext context, User? user) {
    if (user != null) {
      saveUser(user);
      _user = user;
      Navigator.pushReplacementNamed(context, 'home', arguments: user);
    } else {
      cleanUser();
      _user = null;
      Navigator.pushReplacementNamed(context, 'login');
    }
  }

  Future<void> saveUser(User user) async {
    final instance = await SharedPreferences.getInstance();
    await instance.setString('user', user.toJson());
    return;
  }

  Future<void> cleanUser() async {
    final instance = await SharedPreferences.getInstance();
    await instance.remove('user');
    return;
  }

  Future<void> currentUser(BuildContext context) async {
    final instance = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 2));
    if (instance.containsKey('user')) {
      final json = instance.get('user') as String;
      setUser(context, User.fromJson(json));
      return;
    } else {
      setUser(context, null);
    }
  }
}
