import 'package:ttt_merchant_flutter/models/purchase/products_model.dart';

part '../parts/purchase_request.dart';

class PurchaseRequest {
  String? cardNumber;
  List<Products>? products;

  PurchaseRequest({this.cardNumber, this.products});
  static $fromJson(Map<String, dynamic> json) =>
      _$PurchaseRequestFromJson(json);

  factory PurchaseRequest.fromJson(Map<String, dynamic> json) =>
      _$PurchaseRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PurchaseRequestToJson(this);
}
