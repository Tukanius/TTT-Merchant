import 'package:ttt_merchant_flutter/models/check_card.dart';
import 'package:ttt_merchant_flutter/models/user_info.dart';

part '../parts/card_balance.dart';

class CardBalance {
  CheckCard? card;
  String? appUserId;
  UserInfo? userInfo;

  CardBalance({this.card, this.appUserId, this.userInfo});
  static $fromJson(Map<String, dynamic> json) => _$CardBalanceFromJson(json);

  factory CardBalance.fromJson(Map<String, dynamic> json) =>
      _$CardBalanceFromJson(json);
  Map<String, dynamic> toJson() => _$CardBalanceToJson(this);
}
