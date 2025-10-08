part of '../../../models/income_models/distributor_income_models/income_model.dart';

IncomeModel _$IncomeModelFromJson(Map<String, dynamic> json) {
  return IncomeModel(
    id: json['_id'] != null ? json['_id'] as String : null,
    orderNo: json['orderNo'] != null ? json['orderNo'] as String : null,
    type: json['type'] != null ? json['type'] as String : null,
    vehiclePlateNo: json['vehiclePlateNo'] != null
        ? json['vehiclePlateNo'] as String
        : null,
    driverName: json['driverName'] != null
        ? json['driverName'] as String
        : null,
    toInventory: json['toInventory'] != null
        ? ToInventory.fromJson(json['toInventory'])
        : null,
    fromInventory: json['fromInventory'] != null
        ? FromInventory.fromJson(json['fromInventory'])
        : null,
    transportCompany: json['transportCompany'] != null
        ? TransportCompany.fromJson(json['transportCompany'])
        : null,
    requestStatus: json['requestStatus'] != null
        ? json['requestStatus'] as String
        : null,
    requestStatusDate: json['requestStatusDate'] != null
        ? json['requestStatusDate'] as String
        : null,
    requestStatusHistories: json['requestStatusHistories'] != null
        ? (json['requestStatusHistories'] as List)
              .map((e) => InOutTypes.fromJson(e))
              .toList()
        : null,
    createdAt: json['createdAt'] != null ? json['createdAt'] as String : null,
    products: json['products'] != null
        ? (json['products'] as List)
              .map((e) => ProductPurchaseModel.fromJson(e))
              .toList()
        : null,
    quantity: json['quantity'] != null ? json['quantity'] as num : null,
    totalAmount: json['totalAmount'] != null
        ? json['totalAmount'] as num
        : null,
  );
}

Map<String, dynamic> _$IncomeModelToJson(IncomeModel instance) {
  Map<String, dynamic> json = {};
  if (instance.id != null) json['_id'] = instance.id;
  if (instance.orderNo != null) json['orderNo'] = instance.orderNo;
  if (instance.type != null) json['type'] = instance.type;
  if (instance.vehiclePlateNo != null)
    json['vehiclePlateNo'] = instance.vehiclePlateNo;
  if (instance.driverName != null) json['driverName'] = instance.driverName;
  if (instance.toInventory != null) json['toInventory'] = instance.toInventory;
  if (instance.fromInventory != null)
    json['fromInventory'] = instance.fromInventory;
  if (instance.transportCompany != null)
    json['transportCompany'] = instance.transportCompany;
  if (instance.requestStatus != null)
    json['requestStatus'] = instance.requestStatus;
  if (instance.requestStatusDate != null)
    json['requestStatusDate'] = instance.requestStatusDate;
  if (instance.requestStatusHistories != null)
    json['requestStatusHistories'] = instance.requestStatusHistories;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;
  if (instance.products != null) json['products'] = instance.products;
  if (instance.quantity != null) json['quantity'] = instance.quantity;
  if (instance.totalAmount != null) json['totalAmount'] = instance.totalAmount;

  return json;
}
