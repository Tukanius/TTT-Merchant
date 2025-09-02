part '../parts/check_card.dart';

class CheckCard {
  String? cardNumber;
  int? balance;
  String? cardNo;
  int? availableLimit;
  CheckCard({this.cardNumber, this.balance, this.cardNo, this.availableLimit});
  static $fromJson(Map<String, dynamic> json) => _$CheckCardFromJson(json);

  factory CheckCard.fromJson(Map<String, dynamic> json) =>
      _$CheckCardFromJson(json);
  Map<String, dynamic> toJson() => _$CheckCardToJson(this);
}
