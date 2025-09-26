part '../parts/user_info.dart';

class UserInfo {
  String? registerNo;
  String? lastName;
  String? firstName;

  UserInfo({this.registerNo, this.lastName, this.firstName});

  static $fromJson(Map<String, dynamic> json) => _$UserInfoFromJson(json);

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}
