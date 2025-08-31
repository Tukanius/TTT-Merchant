import 'package:ttt_merchant_flutter/models/income_models/staff_user.dart';
import 'package:ttt_merchant_flutter/models/purchase/products_model.dart';

part '../../parts/income_models/income_model.dart';

class Income {
  String? id;
  String? fromInventory;
  String? toInventory;
  String? transportCompany;
  String? driverName;
  String? vehiclePlateNo;
  String? inOutStatus;
  String? inOutStatusDate;
  String? verifiedStatus;
  String? transportStatus;
  String? createdAt;
  String? updatedAt;
  String? code;
  StaffUser? staffUser;
  StaffUser? senderUser;
  StaffUser? receiverUser;
  int? quantity;
  List<Products>? products;

  Income({
    this.id,
    this.fromInventory,
    this.toInventory,
    this.transportCompany,
    this.driverName,
    this.vehiclePlateNo,
    this.inOutStatus,
    this.inOutStatusDate,
    this.verifiedStatus,
    this.transportStatus,
    this.createdAt,
    this.updatedAt,
    this.code,
    this.staffUser,
    this.senderUser,
    this.receiverUser,
    this.quantity,
    this.products,
  });
  static $fromJson(Map<String, dynamic> json) => _$IncomeFromJson(json);

  factory Income.fromJson(Map<String, dynamic> json) => _$IncomeFromJson(json);
  Map<String, dynamic> toJson() => _$IncomeToJson(this);
}
