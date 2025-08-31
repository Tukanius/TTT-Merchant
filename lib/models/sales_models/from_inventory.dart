part '../../parts/sales_models/from_inventory.dart';

class FromInventory {
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
  String? status;
  String? createdBy;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  FromInventory({
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
    this.status,
    this.createdBy,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });
  static $fromJson(Map<String, dynamic> json) => _$FromInventoryFromJson(json);

  factory FromInventory.fromJson(Map<String, dynamic> json) =>
      _$FromInventoryFromJson(json);
  Map<String, dynamic> toJson() => _$FromInventoryToJson(this);
}
