import 'package:frontend_flutter/models/profile_model.dart';

class UserRequest {
  final String email;
  final String username;
  final List<String> roles;
  final String password;
  final bool active;

  UserRequest(
      {required this.email,
      required this.username,
      required this.roles,
      required this.password,
      required this.active});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'username': username,
      'roles': roles,
      'password': password,
      'active': active
    };
  }
}

class UserResponse {
  final String id;
  final String email;
  final String username;
  final List<String> roles;
  final bool active;
  ProfileShortResponse? profile;

  UserResponse(
      {required this.id,
      required this.email,
      required this.username,
      required this.roles,
      required this.active,
      this.profile});

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
        id: json['id'],
        email: json['email'],
        username: json['username'],
        roles: List<String>.from(json['roles']),
        active: json['active'],
        profile: json['profile']);
  }
}

class CurrentUser {
  final String id;
  final String email;
  final String username;
  final List<String> roles;
  final bool active;
  final Profile profile;

  CurrentUser({
    required this.id,
    required this.email,
    required this.username,
    required this.roles,
    required this.active,
    required this.profile,
  });

  factory CurrentUser.fromJson(Map<String, dynamic> json) {
    return CurrentUser(
      id: json['id'],
      email: json['email'],
      username: json['username'],
      roles: List<String>.from(json['roles']),
      active: json['active'],
      profile: Profile.fromJson(json['profile']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'roles': roles,
      'active': active,
      'profile': profile.toJson(),
    };
  }
}
