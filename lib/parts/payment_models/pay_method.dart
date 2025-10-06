part of '../../models/payment_models/pay_method.dart';

PayMethod _$PayMethodFromJson(Map<String, dynamic> json) {
  return PayMethod(
    paymentMethod: json['paymentMethod'] != null
        ? json['paymentMethod'] as String
        : null,
  );
}

Map<String, dynamic> _$PayMethodToJson(PayMethod instance) {
  Map<String, dynamic> json = {};

  if (instance.paymentMethod != null)
    json['paymentMethod'] = instance.paymentMethod;

  return json;
}
