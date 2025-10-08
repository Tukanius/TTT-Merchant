part of '../../models/purchase_models/purchase_request.dart';

PurchaseRequest _$PurchaseRequestFromJson(Map<String, dynamic> json) {
  return PurchaseRequest(
    cardNumber: json['cardNumber'] != null
        ? json['cardNumber'] as String
        : null,
    products: json['products'] != null
        ? (json['products'] as List)
              .map((e) => ProductPurchaseModel.fromJson(e))
              .toList()
        : null,
    salesType: json['salesType'] != null ? json['salesType'] as String : null,
    appUserId: json['appUserId'] != null ? json['appUserId'] as String : null,
    device: json['device'] != null ? json['device'] as String : null,
  );
}

Map<String, dynamic> _$PurchaseRequestToJson(PurchaseRequest instance) {
  Map<String, dynamic> json = {};

  if (instance.cardNumber != null) json['cardNumber'] = instance.cardNumber;
  if (instance.products != null) json['products'] = instance.products;
  if (instance.salesType != null) json['salesType'] = instance.salesType;
  if (instance.appUserId != null) json['appUserId'] = instance.appUserId;
  if (instance.device != null) json['device'] = instance.device;

  return json;
}
