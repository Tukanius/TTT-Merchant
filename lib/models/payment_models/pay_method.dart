part '../../parts/payment_models/pay_method.dart';

class PayMethod {
  String? paymentMethod;
  PayMethod({this.paymentMethod});
  static $fromJson(Map<String, dynamic> json) => _$PayMethodFromJson(json);

  factory PayMethod.fromJson(Map<String, dynamic> json) =>
      _$PayMethodFromJson(json);
  Map<String, dynamic> toJson() => _$PayMethodToJson(this);
}
