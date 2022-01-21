import 'dart:convert';

class User {
  final String name;
  final String? photoURL;

  User({ required this.name, this.photoURL });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(name: map['name'], photoURL: map['photoURL']);
  }

  factory User.fromJson(String json) => User.fromMap(jsonDecode(json));

  Map<String, dynamic> toMap() => { 'name': name, 'photoURL': photoURL };

  String toJson() => jsonEncode(toMap());
}