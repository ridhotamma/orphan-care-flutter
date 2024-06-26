import 'package:frontend_flutter/models/bedroom_model.dart';

class Profile {
  final String? profilePicture;
  final String? birthday;
  final String? joinDate;
  final String? leaveDate;
  final String bio;
  final String? bedRoomId;
  final String fullName;
  final Address address;
  final String? guardian;
  final BedRoom bedRoom;
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
    required this.address,
    required this.guardian,
    required this.bedRoom,
    required this.phoneNumber,
    required this.gender,
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
      'address': address.toJson(),
      'guardian': guardian,
      'bedRoom': bedRoom.toJson(),
      'phoneNumber': phoneNumber,
      'gender': gender,
    };
  }
}

class Address {
  final String street;
  final String urbanVillage;
  final String subdistrict;
  final String city;
  final String province;
  final String postalCode;

  Address({
    required this.street,
    required this.urbanVillage,
    required this.subdistrict,
    required this.city,
    required this.province,
    required this.postalCode,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json['street'],
      urbanVillage: json['urbanVillage'],
      subdistrict: json['subdistrict'],
      city: json['city'],
      province: json['province'],
      postalCode: json['postalCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'street': street,
      'urbanVillage': urbanVillage,
      'subdistrict': subdistrict,
      'city': city,
      'province': province,
      'postalCode': postalCode,
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
