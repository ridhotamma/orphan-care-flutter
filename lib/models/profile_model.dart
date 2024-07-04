import 'package:frontend_flutter/models/address_model.dart';
import 'package:frontend_flutter/models/bedroom_model.dart';
import 'package:frontend_flutter/models/guardian_model.dart';

class Profile {
  final String? profilePicture;
  final String? birthday;
  final String? birthPlace;
  final String? joinDate;
  final String? leaveDate;
  final String? bio;
  final String? bedRoomId;
  final String? fullName;
  final Address? address;
  final Guardian? guardian;
  final BedRoom? bedRoom;
  final String? phoneNumber;
  final String? gender;

  Profile({
    this.profilePicture,
    this.birthday,
    this.birthPlace,
    this.joinDate,
    this.leaveDate,
    this.bio,
    this.bedRoomId,
    this.fullName,
    this.phoneNumber,
    this.gender,
    this.address,
    this.guardian,
    this.bedRoom,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      profilePicture: json['profilePicture'],
      birthday: json['birthday'],
      birthPlace: json['birthPlace'],
      joinDate: json['joinDate'],
      leaveDate: json['leaveDate'],
      bio: json['bio'],
      bedRoomId: json['bedRoomId'],
      fullName: json['fullName'],
      address:
          json['address'] == null ? null : Address.fromJson(json['address']),
      guardian:
          json['guardian'] == null ? null : Guardian.fromJson(json['guardian']),
      bedRoom:
          json['bedroom'] == null ? null : BedRoom.fromJson(json['bedroom']),
      phoneNumber: json['phoneNumber'],
      gender: json['gender'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'profilePicture': profilePicture,
      'birthday': birthday,
      'birthPlace': birthPlace,
      'joinDate': joinDate,
      'leaveDate': leaveDate,
      'bio': bio,
      'bedRoomId': bedRoomId,
      'fullName': fullName,
      'address': address?.toJson(),
      'guardian': guardian?.toJson(),
      'bedRoom': bedRoom?.toJson(),
      'phoneNumber': phoneNumber,
      'gender': gender,
    };
  }
}
