import 'package:ttt_merchant_flutter/models/check_card.dart';

part '../parts/card_balance.dart';

class CardBalance {
  CheckCard? card;
  String? appUserId;

  CardBalance({this.card, this.appUserId});
  static $fromJson(Map<String, dynamic> json) => _$CardBalanceFromJson(json);

  factory CardBalance.fromJson(Map<String, dynamic> json) =>
      _$CardBalanceFromJson(json);
  Map<String, dynamic> toJson() => _$CardBalanceToJson(this);
}
