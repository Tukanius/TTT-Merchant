part of '../../models/purchase_models/product_purchase_model.dart';

ProductPurchaseModel _$ProductPurchaseModelFromJson(Map<String, dynamic> json) {
  return ProductPurchaseModel(
    id: json['_id'] != null ? json['_id'] as String : null,
    order: json['order'] != null ? json['order'] as String : null,
    mainImage: json['mainImage'] != null
        ? MainImage.fromJson(json['mainImage'])
        : null,
    code: json['code'] != null ? json['code'] as String : null,
    inventory: json['inventory'] != null ? json['inventory'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
    price: json['price'] != null ? json['price'] as int : null,
    quantity: json['quantity'] != null ? json['quantity'] as int : null,
    deletedAt: json['deletedAt'] != null ? json['deletedAt'] as String : null,
    createdAt: json['createdAt'] != null ? json['createdAt'] as String : null,
    updatedAt: json['updatedAt'] != null ? json['updatedAt'] as String : null,
    residual: json['residual'] != null ? json['residual'] as int : null,
    productId: json['productId'] != null ? json['productId'] as String : null,
  );
}

Map<String, dynamic> _$ProductPurchaseModelToJson(
  ProductPurchaseModel instance,
) {
  Map<String, dynamic> json = {};

  if (instance.id != null) json['_id'] = instance.id;
  if (instance.order != null) json['order'] = instance.order;
  if (instance.mainImage != null) json['mainImage'] = instance.mainImage;
  if (instance.code != null) json['code'] = instance.code;
  if (instance.inventory != null) json['inventory'] = instance.inventory;
  if (instance.name != null) json['name'] = instance.name;
  if (instance.price != null) json['price'] = instance.price;
  if (instance.quantity != null) json['quantity'] = instance.quantity;
  if (instance.deletedAt != null) json['deletedAt'] = instance.deletedAt;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;
  if (instance.updatedAt != null) json['updatedAt'] = instance.updatedAt;
  if (instance.residual != null) json['residual'] = instance.residual;
  if (instance.productId != null) json['productId'] = instance.productId;

  return json;
}
