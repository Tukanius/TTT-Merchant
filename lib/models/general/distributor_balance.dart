part '../../parts/general/distributor_balance.dart';

class DistributorBalance {
  int? balanceAmount;

  DistributorBalance({this.balanceAmount});
  static $fromJson(Map<String, dynamic> json) => _$DistributorBalanceFromJson(json);

  factory DistributorBalance.fromJson(Map<String, dynamic> json) =>
      _$DistributorBalanceFromJson(json);
  Map<String, dynamic> toJson() => _$DistributorBalanceToJson(this);
}
