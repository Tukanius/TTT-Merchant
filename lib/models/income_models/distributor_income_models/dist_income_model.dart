// import 'package:ttt_merchant_flutter/models/general/inventory_user.dart';
// import 'package:ttt_merchant_flutter/models/income_models/distributor_income_models/in_out_types.dart';
// import 'package:ttt_merchant_flutter/models/income_models/distributor_income_models/staff_user.dart';
// import 'package:ttt_merchant_flutter/models/purchase_models/product_purchase_model.dart';

// part '../../../parts/income_models/distributor_income_models/dist_income_model.dart';

// class DistIncomeModel {
//   String? id;
//   InventoryUser? fromInventory;
//   InventoryUser? toInventory;
//   String? transportCompany;
//   String? driverName;
//   String? vehiclePlateNo;
//   String? inOutStatus;
//   String? inOutStatusDate;
//   String? verifiedStatus;
//   String? transportStatus;
//   String? createdAt;
//   String? updatedAt;
//   String? code;
//   StaffUser? staffUser;
//   StaffUser? senderUser;
//   StaffUser? receiverUser;
//   num? quantity;
//   List<ProductPurchaseModel>? products;
//   num? totalAmount;
//   List<InOutTypes>? inOutTypes;
//   String? inOutType;
//   String? type;

//   DistIncomeModel({
//     this.id,
//     this.fromInventory,
//     this.toInventory,
//     this.transportCompany,
//     this.driverName,
//     this.vehiclePlateNo,
//     this.inOutStatus,
//     this.inOutStatusDate,
//     this.verifiedStatus,
//     this.transportStatus,
//     this.createdAt,
//     this.updatedAt,
//     this.code,
//     this.staffUser,
//     this.senderUser,
//     this.receiverUser,
//     this.quantity,
//     this.products,
//     this.totalAmount,
//     this.inOutTypes,
//     this.inOutType,
//     this.type,
//   });
//   static $fromJson(Map<String, dynamic> json) =>
//       _$DistIncomeModelFromJson(json);

//   factory DistIncomeModel.fromJson(Map<String, dynamic> json) =>
//       _$DistIncomeModelFromJson(json);
//   Map<String, dynamic> toJson() => _$DistIncomeModelToJson(this);
// }
