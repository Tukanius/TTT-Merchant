part of '../../models/general/distributor_balance.dart';

DistributorBalance _$DistributorBalanceFromJson(Map<String, dynamic> json) {
  return DistributorBalance(
    balanceAmount: json['balanceAmount'] != null
        ? json['balanceAmount'] as int
        : null,
  );
}

Map<String, dynamic> _$DistributorBalanceToJson(DistributorBalance instance) {
  Map<String, dynamic> json = {};

  if (instance.balanceAmount != null)
    json['balanceAmount'] = instance.balanceAmount;

  return json;
}
