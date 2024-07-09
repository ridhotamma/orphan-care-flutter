import 'package:frontend_flutter/models/profile_model.dart';

class UserRequest {
  final String email;
  final String username;
  final List<String> roles;
  final String password;
  final bool active;
  final String profilePicture;
  final String birthday;
  final String birthPlace;
  final String joinDate;
  final String bio;
  final String bedRoomId;
  final String fullName;
  final Map<String, dynamic> address;
  final Map<String, dynamic> guardian;
  final String phoneNumber;
  final String gender;

  UserRequest({
    required this.email,
    required this.username,
    required this.roles,
    required this.password,
    required this.active,
    required this.profilePicture,
    required this.birthday,
    required this.birthPlace,
    required this.joinDate,
    required this.bio,
    required this.bedRoomId,
    required this.fullName,
    required this.address,
    required this.guardian,
    required this.phoneNumber,
    required this.gender,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'username': username,
      'roles': roles,
      'password': password,
      'active': active,
      'profilePicture': profilePicture,
      'birthday': birthday,
      'birthPlace': birthPlace,
      'joinDate': joinDate,
      'bio': bio,
      'bedRoomId': bedRoomId,
      'fullName': fullName,
      'address': address,
      'guardian': guardian,
      'phoneNumber': phoneNumber,
      'gender': gender,
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

  static UserResponse empty() {
    return UserResponse(
      id: '',
      email: '',
      username: '',
      roles: [],
      active: false,
      profile: Profile.empty(),
    );
  }
}
