part '../../parts/card_models/charge_wallet.dart';

class ChargeWallet {
  num? amount;
  ChargeWallet({this.amount});
  static $fromJson(Map<String, dynamic> json) => _$ChargeWalletFromJson(json);

  factory ChargeWallet.fromJson(Map<String, dynamic> json) =>
      _$ChargeWalletFromJson(json);
  Map<String, dynamic> toJson() => _$ChargeWalletToJson(this);
}
