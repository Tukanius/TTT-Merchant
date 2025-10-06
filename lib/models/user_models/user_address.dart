part '../../parts/user_models/user_address.dart';

class UserAddress {
  String? id;
  String? name;
  String? parent;
  num? level;
  UserAddress({this.id, this.name, this.parent, this.level});
  factory UserAddress.fromJson(Map<String, dynamic> json) =>
      _$UserAddressFromJson(json);
  Map<String, dynamic> toJson() => _$UserAddressToJson(this);
}
