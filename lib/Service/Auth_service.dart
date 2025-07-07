import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:nursery_love_care/core/cache/shared_pref_helper.dart';
import 'package:nursery_love_care/main.dart';

class AuthService {
  static Future<LoginRespones> login(String email, String password) async {
    try {
      var dio = Dio();
      final response = await dio.post(
        'https://loveandcarenursery.com/api/auth/login',
        data: {'email': email, 'password': password},
      );
      log(response.data.toString());
      SharedPrefHelper.setData(StorageKeys.token, response.data['token']);
      return LoginRespones.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> logout() async {
    try {
      var dio = Dio();
      final token = await SharedPrefHelper.getString(StorageKeys.token);

      final response = await dio.post(
        'https://loveandcarenursery.com/api/auth/logout',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      log("Logout Response: ${response.data}");
      // Clear the token after successful logout
      await SharedPrefHelper.removeData(StorageKeys.token);
    } catch (e) {
      log("Logout error: $e");
      rethrow;
    }
  }
}


class LoginRespones {
  final String token;
  final String message;
  final String tokenType;
  final UserModel user;

  LoginRespones({
    required this.token,
    required this.message,
    required this.tokenType,
    required this.user,
  });

  factory LoginRespones.fromJson(Map<String, dynamic> json) {
    return LoginRespones(
      token: json['token'],
      message: json['message'],
      tokenType: json['token_type'] ?? 'Bearer',
      user: UserModel.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() => {
    'token': token,
    'message': message,
    'token_type': tokenType,
    'user': user.toJson(),
  };
}

class UserModel {
  final int id;
  final String name;
  final String email;
  final String role;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'role': role,
  };
}
