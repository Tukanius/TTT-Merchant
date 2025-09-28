import 'package:ttt_merchant_flutter/models/purchase_models/product_purchase_model.dart';

part '../parts/order_products.dart';

class OrderProducts {
  ProductPurchaseModel? product;
  num? weight;
  int? totalCount;
  OrderProducts({this.product, this.weight, this.totalCount});
  static $fromJson(Map<String, dynamic> json) => _$OrderProductsFromJson(json);

  factory OrderProducts.fromJson(Map<String, dynamic> json) =>
      _$OrderProductsFromJson(json);
  Map<String, dynamic> toJson() => _$OrderProductsToJson(this);
}
