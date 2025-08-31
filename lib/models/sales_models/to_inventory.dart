part '../../parts/sales_models/to_inventory.dart';

class ToInventory {
  String? id;
  String? customer;
  bool? isDeleted;
  String? staffUser;
  bool? isActive;
  bool? isCounting;
  bool? isIncome;
  bool? isQuantity;
  String? type;
  String? name;
  String? createdBy;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  ToInventory({
    this.id,
    this.customer,
    this.isDeleted,
    this.staffUser,
    this.isActive,
    this.isCounting,
    this.isIncome,
    this.isQuantity,
    this.type,
    this.name,
    this.createdBy,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });
  static $fromJson(Map<String, dynamic> json) => _$ToInventoryFromJson(json);

  factory ToInventory.fromJson(Map<String, dynamic> json) =>
      _$ToInventoryFromJson(json);
  Map<String, dynamic> toJson() => _$ToInventoryToJson(this);
}
