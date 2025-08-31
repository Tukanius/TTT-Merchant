part of '../models/purchase_request.dart';

PurchaseRequest _$PurchaseRequestFromJson(Map<String, dynamic> json) {
  return PurchaseRequest(
    cardNumber: json['cardNumber'] != null
        ? json['cardNumber'] as String
        : null,
    products: json['products'] != null
        ? (json['products'] as List).map((e) => Products.fromJson(e)).toList()
        : null,
  );
}

Map<String, dynamic> _$PurchaseRequestToJson(PurchaseRequest instance) {
  Map<String, dynamic> json = {};

  if (instance.cardNumber != null) json['cardNumber'] = instance.cardNumber;
  if (instance.products != null) json['products'] = instance.products;

  return json;
}
