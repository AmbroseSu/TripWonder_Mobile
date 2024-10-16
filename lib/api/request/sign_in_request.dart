import 'package:flutter/material.dart';

class SignInRequest {
  final String login;
  final String password;

  SignInRequest({
    required this.login,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'login': login,
      'password': password,
    };
  }
}
