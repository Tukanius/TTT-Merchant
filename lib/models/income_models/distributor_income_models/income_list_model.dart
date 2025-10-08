import 'package:ttt_merchant_flutter/models/income_models/distributor_income_models/in_out_types.dart';
import 'package:ttt_merchant_flutter/models/income_models/distributor_income_models/transport_company.dart';
import 'package:ttt_merchant_flutter/models/purchase_models/product_purchase_model.dart';
import 'package:ttt_merchant_flutter/models/sales_models/from_inventory.dart';
import 'package:ttt_merchant_flutter/models/sales_models/to_inventory.dart';

part '../../../parts/income_models/distributor_income_models/income_list_model.dart';

class IncomeListModel {
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
  num? quantity;
  List<ProductPurchaseModel>? products;

  IncomeListModel({
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
    this.quantity,
    this.products,
  });
  static $fromJson(Map<String, dynamic> json) =>
      _$IncomeListModelFromJson(json);

  factory IncomeListModel.fromJson(Map<String, dynamic> json) =>
      _$IncomeListModelFromJson(json);
  Map<String, dynamic> toJson() => _$IncomeListModelToJson(this);
}
