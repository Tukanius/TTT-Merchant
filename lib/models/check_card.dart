part '../parts/check_card.dart';

class CheckCard {
  String? cardNumber;
  String? cardNo;
  int? availableLimit;
  String? appUserId;
  CheckCard({
    this.cardNumber,
    this.cardNo,
    this.availableLimit,
    this.appUserId,
  });
  static $fromJson(Map<String, dynamic> json) => _$CheckCardFromJson(json);

  factory CheckCard.fromJson(Map<String, dynamic> json) =>
      _$CheckCardFromJson(json);
  Map<String, dynamic> toJson() => _$CheckCardToJson(this);
}
