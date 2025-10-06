part '../../parts/card_models/wallet_transaction.dart';

class WalletTransaction {
  String? id;
  // Order? order;
  // Distributor? distributor;
  num? amount;
  String? paymentMethod;
  String? description;
  String? type;
  String? createdAt;
  String? updatedAt;
  num? balanceAfter;

  WalletTransaction({
    this.id,
    this.amount,
    this.paymentMethod,
    this.description,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.balanceAfter,
  });
  static $fromJson(Map<String, dynamic> json) =>
      _$WalletTransactionFromJson(json);

  factory WalletTransaction.fromJson(Map<String, dynamic> json) =>
      _$WalletTransactionFromJson(json);
  Map<String, dynamic> toJson() => _$WalletTransactionToJson(this);
}
