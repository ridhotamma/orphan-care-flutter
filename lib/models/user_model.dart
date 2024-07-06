import 'package:frontend_flutter/models/profile_model.dart';

class UserRequest {
  final String email;
  final String username;
  final List<String> roles;
  final String password;
  final bool active;
  final Profile profile;

  UserRequest(
      {required this.email,
      required this.username,
      required this.roles,
      required this.password,
      required this.active,
      required this.profile});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'username': username,
      'roles': roles,
      'password': password,
      'active': active,
      'profile': profile
    };
  }
}

class UserResponse {
  final String id;
  final String email;
  final String username;
  final List<String> roles;
  final bool active;
  final Profile profile;

  UserResponse({
    required this.id,
    required this.email,
    required this.username,
    required this.roles,
    required this.active,
    required this.profile,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      id: json['id'],
      email: json['email'],
      username: json['username'],
      roles: List<String>.from(json['roles']),
      active: json['active'],
      profile: Profile.fromJson(json['profile']),
    );
  }
}
