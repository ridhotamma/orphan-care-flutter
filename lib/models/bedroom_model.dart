class BedRoom {
  final String id;
  final String name;
  final String? bedRoomTypeId;
  final BedRoomType bedRoomType;

  BedRoom({
    required this.id,
    required this.name,
    required this.bedRoomTypeId,
    required this.bedRoomType,
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
      'bedRoomType': bedRoomType.toJson(),
    };
  }
}

class BedRoomType {
  final String id;
  final String name;
  final String type;

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
}
