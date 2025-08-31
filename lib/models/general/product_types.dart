import 'package:ttt_merchant_flutter/models/general/unit_model.dart';

part '../../parts/general/product_types.dart';

class ProductTypes {
  String? id;
  String? name;
  String? code;
  List<String>? images;
  Unit? unit;
  int? perWeight;
  int? price;

  ProductTypes({
    this.id,
    this.name,
    this.code,
    this.images,
    this.unit,
    this.perWeight,
    this.price,
  });
  static $fromJson(Map<String, dynamic> json) => _$ProductTypesFromJson(json);

  factory ProductTypes.fromJson(Map<String, dynamic> json) =>
      _$ProductTypesFromJson(json);
  Map<String, dynamic> toJson() => _$ProductTypesToJson(this);
}
