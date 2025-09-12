part '../parts/charge_wallet.dart';

class ChargeWallet {
  int? amount;
  ChargeWallet({this.amount});
  static $fromJson(Map<String, dynamic> json) => _$ChargeWalletFromJson(json);

  factory ChargeWallet.fromJson(Map<String, dynamic> json) =>
      _$ChargeWalletFromJson(json);
  Map<String, dynamic> toJson() => _$ChargeWalletToJson(this);
}
