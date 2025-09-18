part of '../../models/purchase_models/purchase_model.dart';

PurchaseModel _$PurchaseModelFromJson(Map<String, dynamic> json) {
  return PurchaseModel(
    orderStatus: json['orderStatus'] != null
        ? json['orderStatus'] as String
        : null,
    salesType: json['salesType'] != null ? json['salesType'] as String : null,
    id: json['_id'] != null ? json['_id'] as String : null,
    type: json['type'] != null ? json['type'] as String : null,
    user: json['user'] != null ? User.fromJson(json['user']) : null,
    invoice: json['invoice'] != null ? Invoice.fromJson(json['invoice']) : null,

    code: json['code'] != null ? json['code'] as String : null,
    quantity: json['quantity'] != null ? json['quantity'] as int : null,
    totalAmount: json['totalAmount'] != null
        ? json['totalAmount'] as int
        : null,
    payAmount: json['payAmount'] != null ? json['payAmount'] as int : null,
    paidAmount: json['paidAmount'] != null ? json['paidAmount'] as int : null,
    orderStatusDate: json['orderStatusDate'] != null
        ? json['orderStatusDate'] as String
        : null,
    deletedAt: json['deletedAt'] != null ? json['deletedAt'] as String : null,
    createdAt: json['createdAt'] != null ? json['createdAt'] as String : null,
    updatedAt: json['updatedAt'] != null ? json['updatedAt'] as String : null,
    products: json['products'] != null
        ? (json['products'] as List)
              .map((e) => ProductPurchaseModel.fromJson(e))
              .toList()
        : null,
    distributor: json['distributor'] != null
        ? StaffUser.fromJson(json['distributor'])
        : null,
    appUser: json['appUser'] != null
        ? StaffUser.fromJson(json['appUser'])
        : null,
    cardNo: json['cardNo'] != null ? json['cardNo'] as String : null,
    payType: json['payType'] != null ? json['payType'] as String : null,
  );
}

Map<String, dynamic> _$PurchaseModelToJson(PurchaseModel instance) {
  Map<String, dynamic> json = {};
  if (instance.orderStatus != null) json['orderStatus'] = instance.orderStatus;
  if (instance.salesType != null) json['salesType'] = instance.salesType;
  if (instance.id != null) json['_id'] = instance.id;
  if (instance.type != null) json['type'] = instance.type;
  if (instance.user != null) json['user'] = instance.user;
  if (instance.code != null) json['code'] = instance.code;
  if (instance.quantity != null) json['quantity'] = instance.quantity;
  if (instance.totalAmount != null) json['totalAmount'] = instance.totalAmount;
  if (instance.payAmount != null) json['payAmount'] = instance.payAmount;
  if (instance.paidAmount != null) json['paidAmount'] = instance.paidAmount;
  if (instance.orderStatusDate != null)
    json['orderStatusDate'] = instance.orderStatusDate;
  if (instance.deletedAt != null) json['deletedAt'] = instance.deletedAt;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;
  if (instance.updatedAt != null) json['updatedAt'] = instance.updatedAt;
  if (instance.products != null) json['products'] = instance.products;
  if (instance.distributor != null) json['distributor'] = instance.distributor;
  // if (instance.confirmedUser != null)
  //   json['confirmedUser'] = instance.confirmedUser;
  if (instance.appUser != null) json['appUser'] = instance.appUser;
  if (instance.cardNo != null) json['cardNo'] = instance.cardNo;
  if (instance.invoice != null) json['invoice'] = instance.invoice;
  if (instance.payType != null) json['payType'] = instance.payType;

  return json;
}
