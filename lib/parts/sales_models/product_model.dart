part of '../../models/sales_models/product_model.dart';

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
    id: json['_id'] != null ? json['_id'] as String : null,
    isActive: json['isActive'] != null ? json['isActive'] as bool : null,
    isDeleted: json['isDeleted'] != null ? json['isDeleted'] as bool : null,
    name: json['name'] != null ? json['name'] as String : null,
    code: json['code'] != null ? json['code'] as String : null,
    images: json['images'] != null
        ? (json['images'] as List).map((e) => e as String).toList()
        : null,
    type: json['type'] != null ? json['type'] as String : null,
    deletedAt: json['deletedAt'] != null ? json['deletedAt'] as String : null,
    createdAt: json['createdAt'] != null ? json['createdAt'] as String : null,
    updatedAt: json['updatedAt'] != null ? json['updatedAt'] as String : null,
    unit: json['unit'] != null ? json['unit'] as String : null,
    perWeight: json['perWeight'] != null ? json['perWeight'] as num : null,
    price: json['price'] != null ? json['price'] as num : null,
  );
}

Map<String, dynamic> _$ProductToJson(Product instance) {
  Map<String, dynamic> json = {};

  if (instance.id != null) json['_id'] = instance.id;
  if (instance.isActive != null) json['isActive'] = instance.isActive;
  if (instance.isDeleted != null) json['isDeleted'] = instance.isDeleted;
  if (instance.name != null) json['name'] = instance.name;
  if (instance.code != null) json['code'] = instance.code;
  if (instance.images != null) json['images'] = instance.images;
  if (instance.type != null) json['type'] = instance.type;
  if (instance.deletedAt != null) json['deletedAt'] = instance.deletedAt;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;
  if (instance.updatedAt != null) json['updatedAt'] = instance.updatedAt;
  if (instance.unit != null) json['unit'] = instance.unit;
  if (instance.perWeight != null) json['perWeight'] = instance.perWeight;
  if (instance.price != null) json['price'] = instance.price;

  return json;
}
