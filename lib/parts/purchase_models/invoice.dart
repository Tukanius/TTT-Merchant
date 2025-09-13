part of '../../models/purchase_models/invoice.dart';

Invoice _$InvoiceFromJson(Map<String, dynamic> json) {
  return Invoice(id: json['_id'] != null ? json['_id'] as String : null);
}

Map<String, dynamic> _$InvoiceToJson(Invoice instance) {
  Map<String, dynamic> json = {};

  if (instance.id != null) json['_id'] = instance.id;
  return json;
}
