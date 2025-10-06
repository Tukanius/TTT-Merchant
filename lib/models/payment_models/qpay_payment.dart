import 'package:ttt_merchant_flutter/models/payment_models/qpay_model.dart';

part '../../parts/payment_models/qpay_payment.dart';

class QpayPayment {
  String? id;
  String? order;
  num? amount;
  String? paymentMethod;
  String? qpayInvoiceId;
  Qpay? qpay;
  String? description;
  String? status;
  String? statusDate;
  String? createdAt;
  String? updatedAt;

  QpayPayment({
    this.id,
    this.order,
    this.amount,
    this.paymentMethod,
    this.qpayInvoiceId,
    this.qpay,
    this.description,
    this.status,
    this.statusDate,
    this.createdAt,
    this.updatedAt,
  });
  static $fromJson(Map<String, dynamic> json) => _$QpayPaymentFromJson(json);

  factory QpayPayment.fromJson(Map<String, dynamic> json) =>
      _$QpayPaymentFromJson(json);
  Map<String, dynamic> toJson() => _$QpayPaymentToJson(this);
}
