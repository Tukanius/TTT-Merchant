part of '../../models/sales_models/request_product.dart';

RequestProduct _$RequestProductFromJson(Map<String, dynamic> json) {
  return RequestProduct(
    id: json['_id'] != null ? json['_id'] as String : null,
    product: json['product'] != null ? Product.fromJson(json['product']) : null,
    totalCount: json['totalCount'] != null ? json['totalCount'] as int : null,
    weight: json['weight'] != null ? json['weight'] as int : null,
  );
}

Map<String, dynamic> _$RequestProductToJson(RequestProduct instance) {
  Map<String, dynamic> json = {};

  if (instance.id != null) json['_id'] = instance.id;
  if (instance.product != null) json['product'] = instance.product;
  if (instance.totalCount != null) json['totalCount'] = instance.totalCount;
  if (instance.weight != null) json['weight'] = instance.weight;

  return json;
}
