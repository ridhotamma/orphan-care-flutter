class AnalyticData {
  final int bedRoomCount;
  final int userCount;
  final int adminCount;
  final int inventoryCount;

  AnalyticData({
    required this.bedRoomCount,
    required this.userCount,
    required this.adminCount,
    required this.inventoryCount,
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
