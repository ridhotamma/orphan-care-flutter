class InventoryType {
  final String id;
  final String name;
  final String type;

  InventoryType({
    required this.id,
    required this.name,
    required this.type,
  });

  factory InventoryType.fromJson(Map<String, dynamic> json) {
    return InventoryType(
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

class InventoryInput {
  final String name;
  final int quantity;
  final String inventoryTypeId;

  InventoryInput(
      {required this.name,
      required this.quantity,
      required this.inventoryTypeId});

  factory InventoryInput.fromJson(Map<String, dynamic> json) {
    return InventoryInput(
      name: json['name'],
      quantity: json['quantity'],
      inventoryTypeId: json['inventoryTypeId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quantity': quantity,
      'inventoryTypeId': inventoryTypeId,
    };
  }
}

class Inventory {
  final String id;
  final String name;
  final int quantity;
  final String inventoryTypeId;
  final InventoryType inventoryType;

  Inventory({
    required this.id,
    required this.name,
    required this.quantity,
    required this.inventoryTypeId,
    required this.inventoryType,
  });

  factory Inventory.fromJson(Map<String, dynamic> json) {
    return Inventory(
      id: json['id'],
      name: json['name'],
      quantity: json['quantity'],
      inventoryTypeId: json['inventoryTypeId'],
      inventoryType: InventoryType.fromJson(json['inventoryType']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'inventoryTypeId': inventoryTypeId,
      'inventoryType': inventoryType.toJson(),
    };
  }
}
