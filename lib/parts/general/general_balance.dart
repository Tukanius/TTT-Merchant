part of '../../models/general/general_balance.dart';

GeneralBalance _$GeneralBalanceFromJson(Map<String, dynamic> json) {
  return GeneralBalance(
    lastBalance: json['lastBalance'] != null
        ? json['lastBalance'] as num
        : null,
  );
}

Map<String, dynamic> _$GeneralBalanceToJson(GeneralBalance instance) {
  Map<String, dynamic> json = {};

  if (instance.lastBalance != null) json['lastBalance'] = instance.lastBalance;

  return json;
}
