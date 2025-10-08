import 'package:ttt_merchant_flutter/models/purchase_models/product_purchase_model.dart';

part '../../parts/purchase_models/purchase_request.dart';

class PurchaseRequest {
  String? cardNumber;
  String? salesType;
  List<ProductPurchaseModel>? products;
  String? appUserId;
  String? device;

  PurchaseRequest({
    this.cardNumber,
    this.products,
    this.salesType,
    this.appUserId,
    this.device,
  });
  static $fromJson(Map<String, dynamic> json) =>
      _$PurchaseRequestFromJson(json);

  factory PurchaseRequest.fromJson(Map<String, dynamic> json) =>
      _$PurchaseRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PurchaseRequestToJson(this);
}
