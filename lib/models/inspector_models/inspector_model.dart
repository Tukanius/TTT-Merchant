part '../../parts/inspector_models/inspector_model.dart';

class InspectorModel {
  String? id;
  String? order;
  String? code;
  String? inventory;
  String? name;
  int? price;
  int? quantity;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  int? residual;
  String? productId;

  InspectorModel({
    this.id,
    this.order,
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
  static $fromJson(Map<String, dynamic> json) => _$InspectorModelFromJson(json);

  factory InspectorModel.fromJson(Map<String, dynamic> json) =>
      _$InspectorModelFromJson(json);
  Map<String, dynamic> toJson() => _$InspectorModelToJson(this);
}
