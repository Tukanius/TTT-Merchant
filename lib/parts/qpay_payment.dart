part of '../models/qpay_payment.dart';

QpayPayment _$QpayPaymentFromJson(Map<String, dynamic> json) {
  return QpayPayment(
    id: json['_id'] != null ? json['_id'] as String : null,
    order: json['order'] != null ? json['order'] as String : null,
    distributor: json['distributor'] != null
        ? json['distributor'] as String
        : null,
    amount: json['amount'] != null ? json['amount'] as int : null,
    paymentMethod: json['paymentMethod'] != null
        ? json['paymentMethod'] as String
        : null,
    qpayInvoiceId: json['qpayInvoiceId'] != null
        ? json['qpayInvoiceId'] as String
        : null,
    description: json['description'] != null
        ? json['description'] as String
        : null,
    status: json['status'] != null ? json['status'] as String : null,
    statusDate: json['statusDate'] != null
        ? json['statusDate'] as String
        : null,
    createdAt: json['createdAt'] != null ? json['createdAt'] as String : null,
    updatedAt: json['updatedAt'] != null ? json['updatedAt'] as String : null,
    qpay: json['qpay'] != null ? Qpay.fromJson(json['qpay']) : null,
  );
}

Map<String, dynamic> _$QpayPaymentToJson(QpayPayment instance) {
  Map<String, dynamic> json = {};
  if (instance.id != null) json['_id'] = instance.id;

  if (instance.order != null) json['order'] = instance.order;
  if (instance.distributor != null) json['distributor'] = instance.distributor;
  if (instance.amount != null) json['amount'] = instance.amount;
  if (instance.paymentMethod != null)
    json['paymentMethod'] = instance.paymentMethod;
  if (instance.qpayInvoiceId != null)
    json['qpayInvoiceId'] = instance.qpayInvoiceId;
  if (instance.qpay != null) json['qpay'] = instance.qpay;
  if (instance.description != null) json['description'] = instance.description;
  if (instance.status != null) json['status'] = instance.status;
  if (instance.statusDate != null) json['statusDate'] = instance.statusDate;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;
  if (instance.updatedAt != null) json['updatedAt'] = instance.updatedAt;

  return json;
}
