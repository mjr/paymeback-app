import 'dart:convert';

class User {
  final String fullName;
  final String? nickname;
  final String? token;

  User({ required this.fullName, this.nickname, this.token });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      fullName: map['fullName'],
      nickname: map['nickname'],
      token: map['token']
    );
  }

  factory User.fromJson(String json) => User.fromMap(jsonDecode(json));

  Map<String, dynamic> toMap() => {
    'fullName': fullName,
    'nickname': nickname,
    'token': token
  };

  String toJson() => jsonEncode(toMap());
}