import 'package:ttt_merchant_flutter/models/purchase/products_model.dart';
import 'package:ttt_merchant_flutter/models/user.dart';

part '../../parts/purchase/purchase_model.dart';

class Purchase {
  String? id;
  String? type;
  User? user;
  String? distributor;
  String? code;
  int? quantity;
  int? totalAmount;
  int? payAmount;
  int? paidAmount;
  String? orderStatusDate;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  List<Products>? products;

  Purchase({
    this.id,
    this.type,
    this.user,
    this.distributor,
    this.code,
    this.quantity,
    this.totalAmount,
    this.payAmount,
    this.paidAmount,
    this.orderStatusDate,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.products,
  });
  static $fromJson(Map<String, dynamic> json) => _$PurchaseFromJson(json);

  factory Purchase.fromJson(Map<String, dynamic> json) =>
      _$PurchaseFromJson(json);
  Map<String, dynamic> toJson() => _$PurchaseToJson(this);
}
