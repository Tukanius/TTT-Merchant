part of '../../models/card_models/check_card.dart';

CheckCard _$CheckCardFromJson(Map<String, dynamic> json) {
  return CheckCard(
    cardNumber: json['cardNumber'] != null
        ? json['cardNumber'] as String
        : null,

    cardNo: json['cardNo'] != null ? json['cardNo'] as String : null,
    availableLimit: json['availableLimit'] != null
        ? json['availableLimit'] as num
        : null,
    appUserId: json['appUserId'] != null ? json['appUserId'] as String : null,
    str: json['str'] != null ? json['str'] as String : null,
    distributorRegnum: json['distributorRegnum'] != null
        ? json['distributorRegnum'] as String
        : null,
  );
}

Map<String, dynamic> _$CheckCardToJson(CheckCard instance) {
  Map<String, dynamic> json = {};

  if (instance.cardNumber != null) json['cardNumber'] = instance.cardNumber;
  if (instance.cardNo != null) json['cardNo'] = instance.cardNo;
  if (instance.availableLimit != null)
    json['availableLimit'] = instance.availableLimit;
  if (instance.appUserId != null) json['appUserId'] = instance.appUserId;
  if (instance.str != null) json['str'] = instance.str;
  if (instance.distributorRegnum != null)
    json['distributorRegnum'] = instance.distributorRegnum;

  return json;
}
