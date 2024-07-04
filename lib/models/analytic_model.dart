class AnalyticData {
  final int? bedRoomCount;
  final int? userCount;
  final int? adminCount;
  final int? inventoryCount;

  AnalyticData({
    this.bedRoomCount,
    this.userCount,
    this.adminCount,
    this.inventoryCount,
  });

  factory AnalyticData.fromJson(Map<String, dynamic> json) {
    return AnalyticData(
      bedRoomCount: json['bedRoomCount'],
      userCount: json['userCount'],
      adminCount: json['adminCount'],
      inventoryCount: json['inventoryCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bedRoomCount': bedRoomCount,
      'userCount': userCount,
      'adminCount': adminCount,
      'inventoryCount': inventoryCount,
    };
  }
}
