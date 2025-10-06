part '../../parts/card_models/check_card.dart';

class CheckCard {
  String? cardNumber;
  String? cardNo;
  num? availableLimit;
  String? appUserId;
  String? str;
  String? distributorRegnum;

  CheckCard({
    this.cardNumber,
    this.cardNo,
    this.availableLimit,
    this.appUserId,
    this.str,
    this.distributorRegnum,
  });
  static $fromJson(Map<String, dynamic> json) => _$CheckCardFromJson(json);

  factory CheckCard.fromJson(Map<String, dynamic> json) =>
      _$CheckCardFromJson(json);
  Map<String, dynamic> toJson() => _$CheckCardToJson(this);
}
