part of '../../models/general/address.dart';

Address _$AddressFromJson(Map<String, dynamic> json) {
  return Address(
    additionalInformation: json['additionalInformation'] != null
        ? json['additionalInformation'] as String
        : null,
  );
}

Map<String, dynamic> _$AddressToJson(Address instance) {
  Map<String, dynamic> json = {};

  if (instance.additionalInformation != null)
    json['additionalInformation'] = instance.additionalInformation;

  return json;
}
