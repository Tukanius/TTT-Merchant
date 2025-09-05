part '../../parts/purchase/products_model.dart';

class Products {
  String? id;
  String? product;
  String? order;
  String? mainImage;
  String? code;
  String? inventory;
  String? name;
  int? price;
  int? quantity;
  String? unit;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  int? residual;

  Products({
    this.id,
    this.product,
    this.order,
    this.mainImage,
    this.code,
    this.inventory,
    this.name,
    this.price,
    this.quantity,
    this.unit,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.residual,
  });
  static $fromJson(Map<String, dynamic> json) => _$ProductsFromJson(json);

  factory Products.fromJson(Map<String, dynamic> json) =>
      _$ProductsFromJson(json);
  Map<String, dynamic> toJson() => _$ProductsToJson(this);
}
