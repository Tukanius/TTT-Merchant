part of '../../models/order_products.dart';

OrderProducts _$OrderProductsFromJson(Map<String, dynamic> json) {
  return OrderProducts(
    product: json['product'] != null
        ? ProductPurchaseModel.fromJson(json['product'])
        : null,
    weight: json['weight'] != null ? json['weight'] as num : null,
    totalCount: json['totalCount'] != null ? json['totalCount'] as num : null,
  );
}

Map<String, dynamic> _$OrderProductsToJson(OrderProducts instance) {
  Map<String, dynamic> json = {};

  if (instance.product != null) json['product'] = instance.product;
  if (instance.weight != null) json['weight'] = instance.weight;
  if (instance.totalCount != null) json['totalCount'] = instance.totalCount;

  return json;
}
