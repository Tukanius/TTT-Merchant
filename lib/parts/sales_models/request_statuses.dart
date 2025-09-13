part of '../../models/sales_models/request_statuses.dart';

RequestStatuses _$RequestStatusesFromJson(Map<String, dynamic> json) {
  return RequestStatuses(
    id: json['_id'] != null ? json['_id'] as String : null,
    status: json['status'] != null ? json['status'] as String : null,
    date: json['date'] != null ? json['date'] as String : null,
  );
}

Map<String, dynamic> _$RequestStatusesToJson(RequestStatuses instance) {
  Map<String, dynamic> json = {};

  if (instance.id != null) json['_id'] = instance.id;
  if (instance.status != null) json['status'] = instance.status;
  if (instance.date != null) json['date'] = instance.date;

  return json;
}
