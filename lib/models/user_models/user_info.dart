part '../../parts/user_models/user_info.dart';

class UserInfo {
  String? registerNo;
  String? lastName;
  String? firstName;
  String? passportAddress;

  UserInfo({
    this.registerNo,
    this.lastName,
    this.firstName,
    this.passportAddress,
  });

  static $fromJson(Map<String, dynamic> json) => _$UserInfoFromJson(json);

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}
