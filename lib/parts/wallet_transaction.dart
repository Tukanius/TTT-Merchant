part of '../models/wallet_transaction.dart';

WalletTransaction _$WalletTransactionFromJson(Map<String, dynamic> json) {
  return WalletTransaction(
    id: json['_id'] != null ? json['_id'] as String : null,
    amount: json['amount'] != null ? json['amount'] as int : null,
    paymentMethod: json['paymentMethod'] != null
        ? json['paymentMethod'] as String
        : null,
    description: json['description'] != null
        ? json['description'] as String
        : null,
    type: json['type'] != null ? json['type'] as String : null,
    createdAt: json['createdAt'] != null ? json['createdAt'] as String : null,
    updatedAt: json['updatedAt'] != null ? json['updatedAt'] as String : null,
    balanceAfter: json['balanceAfter'] != null
        ? json['balanceAfter'] as int
        : null,
  );
}

Map<String, dynamic> _$WalletTransactionToJson(WalletTransaction instance) {
  Map<String, dynamic> json = {};
  if (instance.id != null) json['_id'] = instance.id;

  if (instance.amount != null) json['amount'] = instance.amount;
  if (instance.paymentMethod != null)
    json['paymentMethod'] = instance.paymentMethod;
  if (instance.description != null) json['description'] = instance.description;
  if (instance.type != null) json['type'] = instance.type;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;
  if (instance.updatedAt != null) json['updatedAt'] = instance.updatedAt;
  if (instance.balanceAfter != null)
    json['balanceAfter'] = instance.balanceAfter;

  return json;
}
