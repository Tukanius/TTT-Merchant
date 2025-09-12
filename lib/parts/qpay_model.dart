part of '../models/qpay_model.dart';

Qpay _$QpayFromJson(Map<String, dynamic> json) {
  return Qpay(
    invoiceId: json['invoiceId'] != null ? json['invoiceId'] as String : null,
    qr_text: json['qr_text'] != null ? json['qr_text'] as String : null,
    qr_image: json['qr_image'] != null ? json['qr_image'] as String : null,
    qPayShortUrl: json['qPayShortUrl'] != null
        ? json['qPayShortUrl'] as String
        : null,
    urls: json['urls'] != null
        ? (json['urls'] as List).map((e) => Urls.fromJson(e)).toList()
        : null,
  );
}

Map<String, dynamic> _$QpayToJson(Qpay instance) {
  Map<String, dynamic> json = {};

  if (instance.invoiceId != null) json['invoiceId'] = instance.invoiceId;
  if (instance.qr_text != null) json['qr_text'] = instance.qr_text;
  if (instance.qr_image != null) json['qr_image'] = instance.qr_image;
  if (instance.qPayShortUrl != null)
    json['qPayShortUrl'] = instance.qPayShortUrl;
  if (instance.urls != null) json['urls'] = instance.urls;

  return json;
}
