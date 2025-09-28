import 'package:ttt_merchant_flutter/models/order_products.dart';

part '../../parts/inspector_models/inspector_model.dart';

class InspectorModel {
  String? id;
  String? contractId;
  String? contractPlanId;
  String? contractNo;
  String? email;
  // List<VehicleStatuses>? vehicleStatuses;
  num? orderProductCount;
  List<OrderProducts>? orderProducts;
  String? paymentType;
  // Vehicle? vehicle;
  // ToInventory? toInventory;
  // ToInventory? fromInventory;
  // List<Null>? truckScales;
  String? receiptType;
  // Driver? driver;
  String? vehiclePlateNo;
  num? unladedWeight;
  num? ladedWeight;
  String? driverName;
  String? receiptStatus;
  // List<ReceiptStatuses>? receiptStatuses;
  String? receiptStatusDate;
  bool? isFixed;
  bool? isPrinted;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  num? netWeight;

  InspectorModel({
    this.id,
    this.contractId,
    this.contractPlanId,
    this.contractNo,
    this.email,
    this.orderProductCount,
    this.paymentType,
    this.receiptType,
    this.vehiclePlateNo,
    this.unladedWeight,
    this.ladedWeight,
    this.driverName,
    this.receiptStatus,
    this.receiptStatusDate,
    this.isFixed,
    this.isPrinted,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.netWeight,
    this.orderProducts,
  });
  static $fromJson(Map<String, dynamic> json) => _$InspectorModelFromJson(json);

  factory InspectorModel.fromJson(Map<String, dynamic> json) =>
      _$InspectorModelFromJson(json);
  Map<String, dynamic> toJson() => _$InspectorModelToJson(this);
}
