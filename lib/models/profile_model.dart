import 'package:frontend_flutter/models/address_model.dart';
import 'package:frontend_flutter/models/bedroom_model.dart';

class Profile {
  final String? profilePicture;
  final String? birthday;
  final String? joinDate;
  final String? leaveDate;
  final String bio;
  final String? bedRoomId;
  final String fullName;
  final Address? address;
  final String? guardian;
  final BedRoom? bedRoom;
  final String phoneNumber;
  final String gender;

  Profile({
    required this.profilePicture,
    required this.birthday,
    required this.joinDate,
    required this.leaveDate,
    required this.bio,
    required this.bedRoomId,
    required this.fullName,
    required this.phoneNumber,
    required this.gender,
    this.address,
    this.guardian,
    this.bedRoom,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      profilePicture: json['profilePicture'],
      birthday: json['birthday'],
      joinDate: json['joinDate'],
      leaveDate: json['leaveDate'],
      bio: json['bio'],
      bedRoomId: json['bedRoomId'],
      fullName: json['fullName'],
      address: Address.fromJson(json['address']),
      guardian: json['guardian'],
      bedRoom: BedRoom.fromJson(json['bedRoom']),
      phoneNumber: json['phoneNumber'],
      gender: json['gender'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'profilePicture': profilePicture,
      'birthday': birthday,
      'joinDate': joinDate,
      'leaveDate': leaveDate,
      'bio': bio,
      'bedRoomId': bedRoomId,
      'fullName': fullName,
      'address': address?.toJson(),
      'guardian': guardian,
      'bedRoom': bedRoom?.toJson(),
      'phoneNumber': phoneNumber,
      'gender': gender,
    };
  }
}

class ProfileShortResponse {
  String? fullName;
  String? profilePicture;
  String? phoneNumber;

  ProfileShortResponse({
    this.fullName,
    this.profilePicture,
    this.phoneNumber,
  });

  Map<String, dynamic> toJson() => {
        'fullName': fullName,
        'profilePicture': profilePicture,
        'phoneNumber': phoneNumber,
      };
}
