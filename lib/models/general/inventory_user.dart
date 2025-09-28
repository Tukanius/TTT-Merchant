import 'package:ttt_merchant_flutter/models/general/address.dart';
import 'package:ttt_merchant_flutter/models/income_models/distributor_income_models/staff_user.dart';

part '../../parts/general/inventory_user.dart';

class InventoryUser {
  String? id;
  String? userType;
  StaffUser? staffUser;
  String? name;
  Address? address;
  String? registerNo;

  InventoryUser({
    this.id,
    this.userType,
    this.staffUser,
    this.name,
    this.address,
    this.registerNo,
  });
  static $fromJson(Map<String, dynamic> json) => _$InventoryUserFromJson(json);

  factory InventoryUser.fromJson(Map<String, dynamic> json) =>
      _$InventoryUserFromJson(json);
  Map<String, dynamic> toJson() => _$InventoryUserToJson(this);
}
