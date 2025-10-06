import 'package:ttt_merchant_flutter/models/general/main_image.dart';

part '../../parts/purchase_models/product_purchase_model.dart';

class ProductPurchaseModel {
  String? id;
  String? order;
  MainImage? mainImage;
  String? code;
  String? inventory;
  String? name;
  num? price;
  num? quantity;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  num? residual;
  String? productId;

  ProductPurchaseModel({
    this.id,
    this.order,
    this.mainImage,
    this.code,
    this.inventory,
    this.name,
    this.price,
    this.quantity,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.residual,
    this.productId,
  });
  static $fromJson(Map<String, dynamic> json) =>
      _$ProductPurchaseModelFromJson(json);

  factory ProductPurchaseModel.fromJson(Map<String, dynamic> json) =>
      _$ProductPurchaseModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductPurchaseModelToJson(this);
}
