part '../../parts/general/request_types.dart';

class RequestTypes {
  String? code;
  String? name;

  RequestTypes({this.code, this.name});
  static $fromJson(Map<String, dynamic> json) => _$RequestTypesFromJson(json);

  factory RequestTypes.fromJson(Map<String, dynamic> json) =>
      _$RequestTypesFromJson(json);
  Map<String, dynamic> toJson() => _$RequestTypesToJson(this);
}
