import 'package:ttt_merchant_flutter/models/urls.dart';

part '../parts/qpay_model.dart';

class Qpay {
  String? invoiceId;
  String? qr_text;
  String? qr_image;
  String? qPayShortUrl;
  List<Urls>? urls;

  Qpay({
    this.invoiceId,
    this.qr_text,
    this.qr_image,
    this.qPayShortUrl,
    this.urls,
  });
  static $fromJson(Map<String, dynamic> json) => _$QpayFromJson(json);

  factory Qpay.fromJson(Map<String, dynamic> json) => _$QpayFromJson(json);
  Map<String, dynamic> toJson() => _$QpayToJson(this);
}
