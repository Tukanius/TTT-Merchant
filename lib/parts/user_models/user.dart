part of '../../models/user_models/user.dart';

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: json['_id'] != null ? json['_id'] as String : null,
    createdAt: json['createdAt'] != null ? json['createdAt'] as String : null,
    updatedAt: json['updatedAt'] != null ? json['updatedAt'] as String : null,
    sessionId: json['sessionId'] != null ? json['sessionId'] as String : null,
    isActive: json['isActive'] != null ? json['isActive'] as bool : null,
    email: json['email'] != null ? json['email'] as String : null,
    username: json['username'] != null ? json['username'] as String : null,
    phone: json['phone'] != null ? json['phone'] as String : null,
    password: json['password'] != null ? json['password'] as String : null,
    sessionScope: json['sessionScope'] != null
        ? json['sessionScope'] as String
        : null,

    passwordExpired: json['passwordExpired'] != null
        ? json['passwordExpired'] as bool
        : null,
    passwordNeedChange: json['passwordNeedChange'] != null
        ? json['passwordNeedChange'] as bool
        : null,
    userStatus: json['userStatus'] != null
        ? json['userStatus'] as String
        : null,
    userStatusDate: json['userStatusDate'] != null
        ? json['userStatusDate'] as String
        : null,
    tokenType: json['tokenType'] != null ? json['tokenType'] as String : null,
    accessToken: json['accessToken'] != null
        ? json['accessToken'] as String
        : null,
    refreshToken: json['refreshToken'] != null
        ? json['refreshToken'] as String
        : null,
    sessionState: json['sessionState'] != null
        ? json['sessionState'] as String
        : null,
    otpCode: json['otpCode'] != null ? json['otpCode'] as String : null,
    otpMethod: json['otpMethod'] != null ? json['otpMethod'] as String : null,
    message: json['message'] != null ? json['message'] as String : null,
    oldPassword: json['oldPassword'] != null
        ? json['oldPassword'] as String
        : null,
    // avatar: json['avatar'] != null ? Avatar.fromJson(json['avatar']) : null,
    firstName: json['firstName'] != null ? json['firstName'] as String : null,
    lastName: json['lastName'] != null ? json['lastName'] as String : null,
    birthDate: json['birthDate'] != null ? json['birthDate'] as String : null,
    gender: json['gender'] != null ? json['gender'] as String : null,
    country: json['country'] != null ? json['country'] as String : null,
    city: json['city'] != null ? json['city'] as String : null,
    state: json['state'] != null ? json['state'] as String : null,
    postalCode: json['postalCode'] != null
        ? json['postalCode'] as String
        : null,

    // avatar: isAvatar(json),
    //  avatar:
    //     json['avatar'] != null ? Avatar.fromJson(json['avatar']) : null,
    newEmail: json['newEmail'] != null ? json['newEmail'] as String : null,
    idToken: json['idToken'] != null ? json['idToken'] as String : null,
    code: json['code'] != null ? json['code'] as String : null,
    deviceToken: json['deviceToken'] != null
        ? json['deviceToken'] as String
        : null,
    isEmailHidden: json['isEmailHidden'] != null
        ? json['isEmailHidden'] as bool
        : null,
    redirect_uri: json['redirect_uri'] != null
        ? json['redirect_uri'] as String
        : null,
    userType: json['userType'] != null ? json['userType'] as String : null,
    registerNo: json['registerNo'] != null
        ? json['registerNo'] as String
        : null,
  );
}

Map<String, dynamic> _$UserToJson(User instance) {
  Map<String, dynamic> json = {};
  if (instance.id != null) json['_id'] = instance.id;
  if (instance.otpCode != null) json['otpCode'] = instance.otpCode;
  if (instance.otpMethod != null) json['otpMethod'] = instance.otpMethod;
  if (instance.tokenType != null) json['tokenType'] = instance.tokenType;
  if (instance.accessToken != null) json['accessToken'] = instance.accessToken;
  if (instance.refreshToken != null)
    json['refreshToken'] = instance.refreshToken;
  if (instance.sessionState != null)
    json['sessionState'] = instance.sessionState;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;
  if (instance.updatedAt != null) json['updatedAt'] = instance.updatedAt;
  if (instance.sessionId != null) json['sessionId'] = instance.sessionId;
  if (instance.isActive != null) json['isActive'] = instance.isActive;
  if (instance.email != null) json['email'] = instance.email;
  if (instance.username != null) json['username'] = instance.username;
  if (instance.phone != null) json['phone'] = instance.phone;
  if (instance.password != null) json['password'] = instance.password;
  if (instance.sessionScope != null)
    json['sessionScope'] = instance.sessionScope;
  if (instance.passwordExpired != null)
    json['passwordExpired'] = instance.passwordExpired;
  if (instance.passwordNeedChange != null)
    json['passwordNeedChange'] = instance.passwordNeedChange;
  if (instance.userStatus != null) json['userStatus'] = instance.userStatus;
  if (instance.userStatusDate != null)
    json['userStatusDate'] = instance.userStatusDate;
  if (instance.message != null) json['message'] = instance.message;
  if (instance.oldPassword != null) json['oldPassword'] = instance.oldPassword;
  if (instance.firstName != null) json['firstName'] = instance.firstName;
  if (instance.lastName != null) json['lastName'] = instance.lastName;
  if (instance.birthDate != null) json['birthDate'] = instance.birthDate;
  if (instance.gender != null) json['gender'] = instance.gender;
  if (instance.country != null) json['country'] = instance.country;
  if (instance.city != null) json['city'] = instance.city;
  if (instance.state != null) json['state'] = instance.state;
  if (instance.postalCode != null) json['postalCode'] = instance.postalCode;
  if (instance.newEmail != null) json['newEmail'] = instance.newEmail;
  if (instance.idToken != null) json['idToken'] = instance.idToken;
  if (instance.code != null) json['code'] = instance.code;
  if (instance.deviceToken != null) json['deviceToken'] = instance.deviceToken;
  if (instance.isEmailHidden != null)
    json['isEmailHidden'] = instance.isEmailHidden;
  if (instance.redirect_uri != null)
    json['redirect_uri'] = instance.redirect_uri;
  if (instance.userType != null) json['userType'] = instance.userType;
  if (instance.registerNo != null) json['registerNo'] = instance.registerNo;

  return json;
}
