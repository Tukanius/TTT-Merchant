part of '../../models/general/product_types.dart';

ProductTypes _$ProductTypesFromJson(Map<String, dynamic> json) {
  return ProductTypes(
    id: json['_id'] != null ? json['_id'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
    code: json['code'] != null ? json['code'] as String : null,
    images: json['images'] != null
        ? (json['images'] as List).map((e) => e as String).toList()
        : null,

    unit: json['unit'] != null ? Unit.fromJson(json['unit']) : null,
    perWeight: json['perWeight'] != null ? json['perWeight'] as int : null,
    price: json['price'] != null ? json['price'] as int : null,
  );
}

Map<String, dynamic> _$ProductTypesToJson(ProductTypes instance) {
  Map<String, dynamic> json = {};

  if (instance.id != null) json['_id'] = instance.id;
  if (instance.name != null) json['name'] = instance.name;
  if (instance.code != null) json['code'] = instance.code;
  if (instance.images != null) json['images'] = instance.images;
  if (instance.unit != null) json['unit'] = instance.unit;
  if (instance.perWeight != null) json['perWeight'] = instance.perWeight;
  if (instance.price != null) json['price'] = instance.price;

  return json;
}
