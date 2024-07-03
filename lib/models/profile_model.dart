import 'package:frontend_flutter/models/address_model.dart';
import 'package:frontend_flutter/models/bedroom_model.dart';

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
  final Map<String, dynamic>? guardian;
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
      profilePicture: json['profilePicture'] as String?,
      birthday: json['birthday'] as String?,
      birthPlace: json['birthPlace'] as String?,
      joinDate: json['joinDate'] as String?,
      leaveDate: json['leaveDate'] as String?,
      bio: json['bio'] as String?,
      bedRoomId: json['bedRoomId'] as String?,
      fullName: json['fullName'] as String?,
      address: Address.fromJson(json['address'] as Map<String, dynamic>),
      guardian: json['guardian'] as Map<String, dynamic>?,
      bedRoom: BedRoom.fromJson(json['bedRoom'] as Map<String, dynamic>),
      phoneNumber: json['phoneNumber'] as String?,
      gender: json['gender'] as String?,
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
      'address': address,
      'guardian': guardian,
      'bedRoom': bedRoom,
      'phoneNumber': phoneNumber,
      'gender': gender,
    };
  }
}
