part of '../models/check_card.dart';

CheckCard _$CheckCardFromJson(Map<String, dynamic> json) {
  return CheckCard(
    cardNumber: json['cardNumber'] != null
        ? json['cardNumber'] as String
        : null,

    balance: json['balance'] != null ? json['balance'] as int : null,
    cardNo: json['cardNo'] != null ? json['cardNo'] as String : null,
    availableLimit: json['availableLimit'] != null
        ? json['availableLimit'] as int
        : null,
  );
}

Map<String, dynamic> _$CheckCardToJson(CheckCard instance) {
  Map<String, dynamic> json = {};

  if (instance.cardNumber != null) json['cardNumber'] = instance.cardNumber;
  if (instance.balance != null) json['balance'] = instance.balance;
  if (instance.cardNo != null) json['cardNo'] = instance.cardNo;
  if (instance.availableLimit != null)
    json['availableLimit'] = instance.availableLimit;

  return json;
}
