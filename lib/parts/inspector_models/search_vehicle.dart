part of '../../models/inspector_models/search_vehicle.dart';

SearchByPlateNo _$SearchByPlateNoFromJson(Map<String, dynamic> json) {
  return SearchByPlateNo(
    vehiclePlateNo: json['vehiclePlateNo'] != null
        ? json['vehiclePlateNo'] as String
        : null,
  );
}

Map<String, dynamic> _$SearchByPlateNoToJson(SearchByPlateNo instance) {
  Map<String, dynamic> json = {};

  if (instance.vehiclePlateNo != null)
    json['vehiclePlateNo'] = instance.vehiclePlateNo;

  return json;
}
