part of '../models/user_card_request.dart';

UserCardRequest _$UserCardRequestFromJson(Map<String, dynamic> json) {
  return UserCardRequest(
    phone: json['phone'] != null ? json['phone'] as String : null,
    registerNo: json['registerNo'] != null
        ? json['registerNo'] as String
        : null,
    lastName: json['lastName'] != null ? json['lastName'] as String : null,
    firstName: json['firstName'] != null ? json['firstName'] as String : null,
    level2: json['level2'] != null ? json['level2'] as String : null,
    level3: json['level3'] != null ? json['level3'] as String : null,
    additionalInformation: json['additionalInformation'] != null
        ? json['additionalInformation'] as String
        : null,
    requestStatus: json['requestStatus'] != null
        ? json['requestStatus'] as String
        : null,
  );
}

Map<String, dynamic> _$UserCardRequestToJson(UserCardRequest instance) {
  Map<String, dynamic> json = {};

  if (instance.phone != null) json['phone'] = instance.phone;
  if (instance.registerNo != null) json['registerNo'] = instance.registerNo;
  if (instance.lastName != null) json['lastName'] = instance.lastName;
  if (instance.firstName != null) json['firstName'] = instance.firstName;
  if (instance.level2 != null) json['level2'] = instance.level2;
  if (instance.level3 != null) json['level3'] = instance.level3;
  if (instance.additionalInformation != null)
    json['additionalInformation'] = instance.additionalInformation;
  if (instance.requestStatus != null)
    json['requestStatus'] = instance.requestStatus;

  return json;
}
