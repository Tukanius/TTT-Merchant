part of '../models/user_info.dart';

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) {
  return UserInfo(
    registerNo: json['registerNo'] != null
        ? json['registerNo'] as String
        : null,
    lastName: json['lastName'] != null ? json['lastName'] as String : null,
    firstName: json['firstName'] != null ? json['firstName'] as String : null,
  );
}

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) {
  Map<String, dynamic> json = {};

  if (instance.registerNo != null) json['registerNo'] = instance.registerNo;
  if (instance.lastName != null) json['lastName'] = instance.lastName;
  if (instance.firstName != null) json['firstName'] = instance.firstName;

  return json;
}
