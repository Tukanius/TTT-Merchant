part '../parts/user_card_request.dart';

class UserCardRequest {
  String? phone;
  String? registerNo;
  String? lastName;
  String? firstName;
  String? level2;
  String? level3;
  String? additionalInformation;

  UserCardRequest({
    this.phone,
    this.registerNo,
    this.lastName,
    this.firstName,
    this.level2,
    this.level3,
    this.additionalInformation,
  });
  static $fromJson(Map<String, dynamic> json) =>
      _$UserCardRequestFromJson(json);

  factory UserCardRequest.fromJson(Map<String, dynamic> json) =>
      _$UserCardRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UserCardRequestToJson(this);
}
