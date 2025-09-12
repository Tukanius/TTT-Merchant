part of '../models/charge_wallet.dart';

ChargeWallet _$ChargeWalletFromJson(Map<String, dynamic> json) {
  return ChargeWallet(
    amount: json['amount'] != null ? json['amount'] as int : null,
  );
}

Map<String, dynamic> _$ChargeWalletToJson(ChargeWallet instance) {
  Map<String, dynamic> json = {};

  if (instance.amount != null) json['amount'] = instance.amount;

  return json;
}
