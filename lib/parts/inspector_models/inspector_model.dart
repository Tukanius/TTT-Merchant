part of '../../models/inspector_models/inspector_model.dart';

InspectorModel _$InspectorModelFromJson(Map<String, dynamic> json) {
  return InspectorModel(
    id: json['_id'] != null ? json['_id'] as String : null,
    contractId: json['contractId'] != null
        ? json['contractId'] as String
        : null,
    contractPlanId: json['contractPlanId'] != null
        ? json['contractPlanId'] as String
        : null,
    contractNo: json['contractNo'] != null
        ? json['contractNo'] as String
        : null,
    email: json['email'] != null ? json['email'] as String : null,
    orderProductCount: json['orderProductCount'] != null
        ? json['orderProductCount'] as num
        : null,
    paymentType: json['paymentType'] != null
        ? json['paymentType'] as String
        : null,
    receiptType: json['receiptType'] != null
        ? json['receiptType'] as String
        : null,
    vehiclePlateNo: json['vehiclePlateNo'] != null
        ? json['vehiclePlateNo'] as String
        : null,
    unladedWeight: json['unladedWeight'] != null
        ? json['unladedWeight'] as num
        : null,
    ladedWeight: json['ladedWeight'] != null
        ? json['ladedWeight'] as num
        : null,
    driverName: json['driverName'] != null
        ? json['driverName'] as String
        : null,
    receiptStatus: json['receiptStatus'] != null
        ? json['receiptStatus'] as String
        : null,
    receiptStatusDate: json['receiptStatusDate'] != null
        ? json['receiptStatusDate'] as String
        : null,
    isFixed: json['isFixed'] != null ? json['isFixed'] as bool : null,
    isPrinted: json['isPrinted'] != null ? json['isPrinted'] as bool : null,
    deletedAt: json['deletedAt'] != null ? json['deletedAt'] as String : null,
    createdAt: json['createdAt'] != null ? json['createdAt'] as String : null,
    updatedAt: json['updatedAt'] != null ? json['updatedAt'] as String : null,
    netWeight: json['netWeight'] != null ? json['netWeight'] as num : null,
    orderProducts: json['orderProducts'] != null
        ? (json['orderProducts'] as List)
              .map((e) => OrderProducts.fromJson(e))
              .toList()
        : null,
    orderNo: json['orderNo'] != null ? json['orderNo'] as String : null,
  );
}

Map<String, dynamic> _$InspectorModelToJson(InspectorModel instance) {
  Map<String, dynamic> json = {};

  if (instance.id != null) json['_id'] = instance.id;
  if (instance.contractId != null) json['contractId'] = instance.contractId;
  if (instance.contractPlanId != null)
    json['contractPlanId'] = instance.contractPlanId;
  if (instance.contractNo != null) json['contractNo'] = instance.contractNo;
  if (instance.email != null) json['email'] = instance.email;
  if (instance.orderProductCount != null)
    json['orderProductCount'] = instance.orderProductCount;
  if (instance.paymentType != null) json['paymentType'] = instance.paymentType;
  if (instance.receiptType != null) json['receiptType'] = instance.receiptType;
  if (instance.vehiclePlateNo != null)
    json['vehiclePlateNo'] = instance.vehiclePlateNo;
  if (instance.unladedWeight != null)
    json['unladedWeight'] = instance.unladedWeight;
  if (instance.ladedWeight != null) json['ladedWeight'] = instance.ladedWeight;
  if (instance.driverName != null) json['driverName'] = instance.driverName;
  if (instance.receiptStatus != null)
    json['receiptStatus'] = instance.receiptStatus;
  if (instance.receiptStatusDate != null)
    json['receiptStatusDate'] = instance.receiptStatusDate;
  if (instance.isFixed != null) json['isFixed'] = instance.isFixed;
  if (instance.isPrinted != null) json['isPrinted'] = instance.isPrinted;
  if (instance.deletedAt != null) json['deletedAt'] = instance.deletedAt;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;
  if (instance.updatedAt != null) json['updatedAt'] = instance.updatedAt;
  if (instance.netWeight != null) json['netWeight'] = instance.netWeight;
  if (instance.orderProducts != null)
    json['orderProducts'] = instance.orderProducts;
  if (instance.orderNo != null) json['orderNo'] = instance.orderNo;

  return json;
}
