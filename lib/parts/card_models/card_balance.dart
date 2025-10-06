part of '../../models/card_models/card_balance.dart';

CardBalance _$CardBalanceFromJson(Map<String, dynamic> json) {
  return CardBalance(
    card: json['card'] != null ? CheckCard.fromJson(json['card']) : null,
    appUserId: json['appUserId'] != null ? json['appUserId'] as String : null,
    userInfo: json['userInfo'] != null
        ? UserInfo.fromJson(json['userInfo'])
        : null,
    cardRequest: json['cardRequest'] != null
        ? UserCardRequest.fromJson(json['cardRequest'])
        : null,
    device: json['device'] != null ? json['device'] as String : null,
  );
}

Map<String, dynamic> _$CardBalanceToJson(CardBalance instance) {
  Map<String, dynamic> json = {};

  if (instance.card != null) json['card'] = instance.card;
  if (instance.appUserId != null) json['appUserId'] = instance.appUserId;
  if (instance.userInfo != null) json['userInfo'] = instance.userInfo;
  if (instance.cardRequest != null) json['cardRequest'] = instance.cardRequest;
  if (instance.device != null) json['device'] = instance.device;

  return json;
}
