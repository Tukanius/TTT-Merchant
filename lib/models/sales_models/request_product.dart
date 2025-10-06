import 'package:ttt_merchant_flutter/models/sales_models/product_model.dart';

part '../../parts/sales_models/request_product.dart';

class RequestProduct {
  String? id;
  Product? product;
  num? totalCount;
  num? weight;

  RequestProduct({this.id, this.product, this.totalCount, this.weight});
  static $fromJson(Map<String, dynamic> json) => _$RequestProductFromJson(json);

  factory RequestProduct.fromJson(Map<String, dynamic> json) =>
      _$RequestProductFromJson(json);
  Map<String, dynamic> toJson() => _$RequestProductToJson(this);
}
