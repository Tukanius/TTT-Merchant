part of '../models/card_balance.dart';

CardBalance _$CardBalanceFromJson(Map<String, dynamic> json) {
  return CardBalance(
    card: json['card'] != null ? CheckCard.fromJson(json['card']) : null,
    appUserId: json['appUserId'] != null ? json['appUserId'] as String : null,
    userInfo: json['userInfo'] != null
        ? UserInfo.fromJson(json['userInfo'])
        : null,
  );
}

Map<String, dynamic> _$CardBalanceToJson(CardBalance instance) {
  Map<String, dynamic> json = {};

  if (instance.card != null) json['card'] = instance.card;
  if (instance.appUserId != null) json['appUserId'] = instance.appUserId;
  if (instance.userInfo != null) json['userInfo'] = instance.userInfo;

  return json;
}
