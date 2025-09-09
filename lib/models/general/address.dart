part '../../parts/general/address.dart';

class Address {
  String? additionalInformation;

  Address({this.additionalInformation});
  static $fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
