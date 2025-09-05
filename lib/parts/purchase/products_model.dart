part of '../../models/purchase/products_model.dart';

Products _$ProductsFromJson(Map<String, dynamic> json) {
  return Products(
    id: json['_id'] != null ? json['_id'] as String : null,
    product: json['product'] != null ? json['product'] as String : null,
    order: json['order'] != null ? json['order'] as String : null,
    mainImage: json['mainImage'] != null ? json['mainImage'] as String : null,
    code: json['code'] != null ? json['code'] as String : null,
    inventory: json['inventory'] != null ? json['inventory'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
    price: json['price'] != null ? json['price'] as int : null,
    quantity: json['quantity'] != null ? json['quantity'] as int : null,
    unit: json['unit'] != null ? json['unit'] as String : null,
    deletedAt: json['deletedAt'] != null ? json['deletedAt'] as String : null,
    createdAt: json['createdAt'] != null ? json['createdAt'] as String : null,
    updatedAt: json['updatedAt'] != null ? json['updatedAt'] as String : null,
    residual: json['residual'] != null ? json['residual'] as int : null,
  );
}

Map<String, dynamic> _$ProductsToJson(Products instance) {
  Map<String, dynamic> json = {};

  if (instance.id != null) json['_id'] = instance.id;
  if (instance.product != null) json['product'] = instance.product;
  if (instance.order != null) json['order'] = instance.order;
  if (instance.mainImage != null) json['mainImage'] = instance.mainImage;
  if (instance.code != null) json['code'] = instance.code;
  if (instance.inventory != null) json['inventory'] = instance.inventory;
  if (instance.name != null) json['name'] = instance.name;
  if (instance.price != null) json['price'] = instance.price;
  if (instance.quantity != null) json['quantity'] = instance.quantity;
  if (instance.unit != null) json['unit'] = instance.unit;
  if (instance.deletedAt != null) json['deletedAt'] = instance.deletedAt;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;
  if (instance.updatedAt != null) json['updatedAt'] = instance.updatedAt;
  if (instance.residual != null) json['residual'] = instance.residual;

  return json;
}
