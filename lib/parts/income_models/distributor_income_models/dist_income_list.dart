part of '../../../models/income_models/distributor_income_models/dist_income_list.dart';

DistIncomeList _$DistIncomeListFromJson(Map<String, dynamic> json) {
  return DistIncomeList(
    id: json['_id'] != null ? json['_id'] as String : null,
    fromInventory: json['fromInventory'] != null
        ? json['fromInventory'] as String
        : null,
    toInventory: json['toInventory'] != null
        ? json['toInventory'] as String
        : null,
    transportCompany: json['transportCompany'] != null
        ? json['transportCompany'] as String
        : null,
    driverName: json['driverName'] != null
        ? json['driverName'] as String
        : null,
    vehiclePlateNo: json['vehiclePlateNo'] != null
        ? json['vehiclePlateNo'] as String
        : null,
    inOutStatus: json['inOutStatus'] != null
        ? json['inOutStatus'] as String
        : null,
    inOutStatusDate: json['inOutStatusDate'] != null
        ? json['inOutStatusDate'] as String
        : null,
    verifiedStatus: json['verifiedStatus'] != null
        ? json['verifiedStatus'] as String
        : null,
    transportStatus: json['transportStatus'] != null
        ? json['transportStatus'] as String
        : null,
    createdAt: json['createdAt'] != null ? json['createdAt'] as String : null,
    updatedAt: json['updatedAt'] != null ? json['updatedAt'] as String : null,
    code: json['code'] != null ? json['code'] as String : null,
    staffUser: json['staffUser'] != null
        ? StaffUser.fromJson(json['staffUser'])
        : null,
    senderUser: json['senderUser'] != null
        ? StaffUser.fromJson(json['senderUser'])
        : null,
    receiverUser: json['receiverUser'] != null
        ? StaffUser.fromJson(json['receiverUser'])
        : null,
    quantity: json['quantity'] != null ? json['quantity'] as int : null,
    products: json['products'] != null
        ? (json['products'] as List)
              .map((e) => ProductPurchaseModel.fromJson(e))
              .toList()
        : null,
    totalAmount: json['totalAmount'] != null
        ? json['totalAmount'] as int
        : null,
  );
}

Map<String, dynamic> _$DistIncomeListToJson(DistIncomeList instance) {
  Map<String, dynamic> json = {};

  if (instance.id != null) json['_id'] = instance.id;
  if (instance.fromInventory != null)
    json['fromInventory'] = instance.fromInventory;
  if (instance.toInventory != null) json['toInventory'] = instance.toInventory;
  if (instance.transportCompany != null)
    json['transportCompany'] = instance.transportCompany;
  if (instance.driverName != null) json['driverName'] = instance.driverName;
  if (instance.vehiclePlateNo != null)
    json['vehiclePlateNo'] = instance.vehiclePlateNo;
  if (instance.inOutStatus != null) json['inOutStatus'] = instance.inOutStatus;
  if (instance.code != null) json['code'] = instance.code;
  if (instance.inOutStatusDate != null)
    json['inOutStatusDate'] = instance.inOutStatusDate;
  if (instance.verifiedStatus != null)
    json['verifiedStatus'] = instance.verifiedStatus;
  if (instance.transportStatus != null)
    json['transportStatus'] = instance.transportStatus;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;
  if (instance.updatedAt != null) json['updatedAt'] = instance.updatedAt;
  if (instance.staffUser != null) json['staffUser'] = instance.staffUser;
  if (instance.senderUser != null) json['senderUser'] = instance.senderUser;
  if (instance.receiverUser != null)
    json['receiverUser'] = instance.receiverUser;
  if (instance.quantity != null) json['quantity'] = instance.quantity;
  if (instance.products != null) json['products'] = instance.products;
  if (instance.totalAmount != null) json['totalAmount'] = instance.totalAmount;

  return json;
}
