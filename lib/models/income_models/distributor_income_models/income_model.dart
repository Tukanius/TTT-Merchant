import 'package:ttt_merchant_flutter/models/income_models/distributor_income_models/in_out_types.dart';
import 'package:ttt_merchant_flutter/models/income_models/distributor_income_models/transport_company.dart';
import 'package:ttt_merchant_flutter/models/purchase_models/product_purchase_model.dart';
import 'package:ttt_merchant_flutter/models/sales_models/from_inventory.dart';
import 'package:ttt_merchant_flutter/models/sales_models/to_inventory.dart';

part '../../../parts/income_models/distributor_income_models/income_model.dart';

class IncomeModel {
  String? id;
  String? orderNo;
  String? type;
  String? vehiclePlateNo;
  String? driverName;
  ToInventory? toInventory;
  FromInventory? fromInventory;
  TransportCompany? transportCompany;
  String? requestStatus;
  String? requestStatusDate;
  List<InOutTypes>? requestStatusHistories;
  String? createdAt;
  List<ProductPurchaseModel>? products;
  num? quantity;
  num? totalAmount;

  IncomeModel({
    this.id,
    this.orderNo,
    this.type,
    this.vehiclePlateNo,
    this.driverName,
    this.toInventory,
    this.fromInventory,
    this.transportCompany,
    this.requestStatus,
    this.requestStatusDate,
    this.requestStatusHistories,
    this.createdAt,
    this.products,
    this.quantity,
    this.totalAmount,
  });
  static $fromJson(Map<String, dynamic> json) => _$IncomeModelFromJson(json);

  factory IncomeModel.fromJson(Map<String, dynamic> json) =>
      _$IncomeModelFromJson(json);
  Map<String, dynamic> toJson() => _$IncomeModelToJson(this);
}
