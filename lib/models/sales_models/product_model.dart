part '../../parts/sales_models/product_model.dart';

class Product {
  String? id;
  bool? isActive;
  bool? isDeleted;
  String? name;
  String? code;
  List<String>? images;
  String? type;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  String? unit;
  int? perWeight;
  int? price;

  Product({
    this.id,
    this.isActive,
    this.isDeleted,
    this.name,
    this.code,
    this.images,
    this.type,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.unit,
    this.perWeight,
    this.price,
  });
  static $fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
