import 'package:frontend_flutter/models/address_model.dart';

class Guardian {
  final String? id;
  final String? fullName;
  final String? phoneNumber;
  final Address? address;
  final GuardianType? guardianType;

  Guardian({
    this.id,
    this.fullName,
    this.phoneNumber,
    this.guardianType,
    this.address,
  });

  factory Guardian.fromJson(Map<String, dynamic> json) {
    return Guardian(
      id: json['id'],
      fullName: json['fullName'],
      phoneNumber: json['phoneNumber'],
      address: Address.fromJson(json['address']),
      guardianType: GuardianType.fromJson(json['guardianType']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'address': address,
      'guardianType': guardianType
    };
  }
}

class GuardianType {
  final String id;
  final String name;
  final String type;

  GuardianType({
    required this.id,
    required this.name,
    required this.type,
  });

  factory GuardianType.fromJson(Map<String, dynamic> json) {
    return GuardianType(
      id: json['id'],
      name: json['name'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
    };
  }
}
