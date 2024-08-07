class BedRoom {
  final String? id;
  final String? name;
  final String? bedRoomTypeId;
  final BedRoomType? bedRoomType;

  BedRoom({
    this.id,
    this.name,
    this.bedRoomTypeId,
    this.bedRoomType,
  });

  factory BedRoom.fromJson(Map<String, dynamic> json) {
    return BedRoom(
      id: json['id'],
      name: json['name'],
      bedRoomTypeId: json['bedRoomTypeId'],
      bedRoomType: BedRoomType.fromJson(json['bedRoomType']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'bedRoomTypeId': bedRoomTypeId,
      'bedRoomType': bedRoomType,
    };
  }

  static BedRoom empty() {
    return BedRoom(
      id: '',
      name: '',
      bedRoomTypeId: '',
      bedRoomType: BedRoomType.empty(),
    );
  }
}

class BedRoomInput {
  final String name;
  final String bedRoomTypeId;

  BedRoomInput({
    required this.name,
    required this.bedRoomTypeId,
  });

  factory BedRoomInput.fromJson(Map<String, dynamic> json) {
    return BedRoomInput(
      name: json['name'],
      bedRoomTypeId: json['bedRoomTypeId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'bedRoomTypeId': bedRoomTypeId,
    };
  }
}

class BedRoomType {
  final String? id;
  final String? name;
  final String? type;

  BedRoomType({
    required this.id,
    required this.name,
    required this.type,
  });

  factory BedRoomType.fromJson(Map<String, dynamic> json) {
    return BedRoomType(
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

  static BedRoomType empty() {
    return BedRoomType(
      id: '',
      name: '',
      type: '',
    );
  }
}
