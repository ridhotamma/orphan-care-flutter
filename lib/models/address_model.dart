class Address {
  final String? street;
  final String? urbanVillage;
  final String? subdistrict;
  final String? city;
  final String? province;
  final String? postalCode;

  Address({
    this.street,
    this.urbanVillage,
    this.subdistrict,
    this.city,
    this.province,
    this.postalCode,
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

  static Address empty() {
    return Address(
      street: '',
      urbanVillage: '',
      subdistrict: '',
      city: '',
      province: '',
      postalCode: '',
    );
  }
}
