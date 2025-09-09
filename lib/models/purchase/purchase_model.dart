import 'package:ttt_merchant_flutter/models/income_models/staff_user.dart';
import 'package:ttt_merchant_flutter/models/purchase/products_model.dart';
import 'package:ttt_merchant_flutter/models/user.dart';

part '../../parts/purchase/purchase_model.dart';

class Purchase {
  String? salesType;
  String? orderStatus;
  String? id;
  String? type;
  User? user;
  StaffUser? distributor;
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
  StaffUser? confirmedUser;
  StaffUser? appUser;
  String? cardNo;

  Purchase({
    this.salesType,
    this.orderStatus,
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
    this.confirmedUser,
    this.appUser,
    this.cardNo,
  });
  static $fromJson(Map<String, dynamic> json) => _$PurchaseFromJson(json);

  factory Purchase.fromJson(Map<String, dynamic> json) =>
      _$PurchaseFromJson(json);
  Map<String, dynamic> toJson() => _$PurchaseToJson(this);
}
