class Profile {
  final String? profilePicture;
  final String? birthday;
  final String? birthPlace;
  final String? joinDate;
  final String? leaveDate;
  final String? bio;
  final String? bedRoomId;
  final String? fullName;
  final Map<String, dynamic>? address;
  final Map<String, dynamic>? guardian;
  final Map<String, dynamic>? bedRoom;
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
      profilePicture: json['profilePicture'] ?? '',
      birthday: json['birthday'] ?? '',
      birthPlace: json['birthPlace'] ?? '',
      joinDate: json['joinDate'] ?? '',
      leaveDate: json['leaveDate'] ?? '',
      bio: json['bio'] ?? '',
      bedRoomId: json['bedRoomId'] ?? '',
      fullName: json['fullName'] ?? '',
      address: json['address'],
      guardian: json['guardian'],
      bedRoom: json['bedRoom'],
      phoneNumber: json['phoneNumber'] ?? '',
      gender: json['gender'] ?? '',
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
