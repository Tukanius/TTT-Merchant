part '../../parts/sales_models/request_statuses.dart';

class RequestStatuses {
  String? id;
  String? status;
  String? date;

  RequestStatuses({this.id, this.status, this.date});
  static $fromJson(Map<String, dynamic> json) =>
      _$RequestStatusesFromJson(json);

  factory RequestStatuses.fromJson(Map<String, dynamic> json) =>
      _$RequestStatusesFromJson(json);
  Map<String, dynamic> toJson() => _$RequestStatusesToJson(this);
}
