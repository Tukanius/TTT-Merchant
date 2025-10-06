import 'package:ttt_merchant_flutter/models/card_models/check_card.dart';
import 'package:ttt_merchant_flutter/models/user_models/user_card_request.dart';
import 'package:ttt_merchant_flutter/models/user_models/user_info.dart';

part '../../parts/card_models/card_balance.dart';

class CardBalance {
  CheckCard? card;
  String? appUserId;
  UserInfo? userInfo;
  UserCardRequest? cardRequest;
  String? device;

  CardBalance({
    this.card,
    this.appUserId,
    this.userInfo,
    this.cardRequest,
    this.device,
  });
  static $fromJson(Map<String, dynamic> json) => _$CardBalanceFromJson(json);

  factory CardBalance.fromJson(Map<String, dynamic> json) =>
      _$CardBalanceFromJson(json);
  Map<String, dynamic> toJson() => _$CardBalanceToJson(this);
}
