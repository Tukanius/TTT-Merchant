part of '../../models/sales_models/from_inventory.dart';

FromInventory _$FromInventoryFromJson(Map<String, dynamic> json) {
  return FromInventory(
    id: json['_id'] != null ? json['_id'] as String : null,
    customer: json['customer'] != null ? json['customer'] as String : null,
    isDeleted: json['isDeleted'] != null ? json['isDeleted'] as bool : null,
    staffUser: json['staffUser'] != null ? json['staffUser'] as String : null,
    isActive: json['isActive'] != null ? json['isActive'] as bool : null,
    isCounting: json['isCounting'] != null ? json['isCounting'] as bool : null,
    isIncome: json['isIncome'] != null ? json['isIncome'] as bool : null,
    isQuantity: json['isQuantity'] != null ? json['isQuantity'] as bool : null,
    type: json['type'] != null ? json['type'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
    status: json['status'] != null ? json['status'] as String : null,
    createdBy: json['createdBy'] != null ? json['createdBy'] as String : null,
    deletedAt: json['deletedAt'] != null ? json['deletedAt'] as String : null,
    createdAt: json['createdAt'] != null ? json['createdAt'] as String : null,
    updatedAt: json['updatedAt'] != null ? json['updatedAt'] as String : null,
  );
}

Map<String, dynamic> _$FromInventoryToJson(FromInventory instance) {
  Map<String, dynamic> json = {};

  if (instance.id != null) json['_id'] = instance.id;
  if (instance.customer != null) json['customer'] = instance.customer;
  if (instance.isDeleted != null) json['isDeleted'] = instance.isDeleted;
  if (instance.staffUser != null) json['staffUser'] = instance.staffUser;
  if (instance.isActive != null) json['isActive'] = instance.isActive;
  if (instance.isCounting != null) json['isCounting'] = instance.isCounting;
  if (instance.isIncome != null) json['isIncome'] = instance.isIncome;
  if (instance.isQuantity != null) json['isQuantity'] = instance.isQuantity;
  if (instance.type != null) json['type'] = instance.type;
  if (instance.name != null) json['name'] = instance.name;
  if (instance.status != null) json['status'] = instance.status;
  if (instance.createdBy != null) json['createdBy'] = instance.createdBy;
  if (instance.deletedAt != null) json['deletedAt'] = instance.deletedAt;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;
  if (instance.updatedAt != null) json['updatedAt'] = instance.updatedAt;

  return json;
}
