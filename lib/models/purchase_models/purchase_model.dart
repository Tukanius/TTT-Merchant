import 'package:ttt_merchant_flutter/models/purchase_models/product_purchase_model.dart';
import 'package:ttt_merchant_flutter/models/income_models/distributor_income_models/staff_user.dart';
import 'package:ttt_merchant_flutter/models/purchase_models/invoice.dart';
import 'package:ttt_merchant_flutter/models/user.dart';

part '../../parts/purchase_models/purchase_model.dart';

class PurchaseModel {
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
  Invoice? invoice;
  String? orderStatusDate;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  List<ProductPurchaseModel>? products;
  StaffUser? confirmedUser;
  StaffUser? appUser;
  String? cardNo;

  PurchaseModel({
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
    this.invoice,
  });
  static $fromJson(Map<String, dynamic> json) => _$PurchaseModelFromJson(json);

  factory PurchaseModel.fromJson(Map<String, dynamic> json) =>
      _$PurchaseModelFromJson(json);
  Map<String, dynamic> toJson() => _$PurchaseModelToJson(this);
}
