part of '../../models/general/general_init.dart';

GeneralInit _$GeneralInitFromJson(Map<String, dynamic> json) {
  return GeneralInit(
    // productTypes: json['productTypes'] != null
    //     ? (json['productTypes'] as List)
    //           .map((e) => ProductTypes.fromJson(e))
    //           .toList()
    //     : null,
    residual: json['residual'] != null
        ? (json['residual'] as List).map((e) => Residual.fromJson(e)).toList()
        : null,

    inventory: json['inventory'] != null
        ? InventoryUser.fromJson(json['inventory'])
        : null,
    products: json['products'] != null
        ? (json['products'] as List).map((e) => Residual.fromJson(e)).toList()
        : null,
  );
}

Map<String, dynamic> _$GeneralInitToJson(GeneralInit instance) {
  Map<String, dynamic> json = {};

  // if (instance.productTypes != null)
  //   json['productTypes'] = instance.productTypes;
  if (instance.residual != null) json['residual'] = instance.residual;
  if (instance.inventory != null) json['inventory'] = instance.inventory;
  if (instance.products != null) json['products'] = instance.products;

  return json;
}
