part '../../parts/general/general_balance.dart';

class GeneralBalance {
  int? lastBalance;

  GeneralBalance({this.lastBalance});
  static $fromJson(Map<String, dynamic> json) => _$GeneralBalanceFromJson(json);

  factory GeneralBalance.fromJson(Map<String, dynamic> json) =>
      _$GeneralBalanceFromJson(json);
  Map<String, dynamic> toJson() => _$GeneralBalanceToJson(this);
}
