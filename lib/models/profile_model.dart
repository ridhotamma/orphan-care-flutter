class ProfileRequest {
  final String profilePicture;

  ProfileRequest({required this.profilePicture});
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
