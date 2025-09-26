part '../../parts/inspector_models/search_vehicle.dart';

class SearchByPlateNo {
  String? vehiclePlateNo;

  SearchByPlateNo({this.vehiclePlateNo});
  static $fromJson(Map<String, dynamic> json) =>
      _$SearchByPlateNoFromJson(json);

  factory SearchByPlateNo.fromJson(Map<String, dynamic> json) =>
      _$SearchByPlateNoFromJson(json);
  Map<String, dynamic> toJson() => _$SearchByPlateNoToJson(this);
}
