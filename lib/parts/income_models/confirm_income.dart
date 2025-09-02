part of '../../models/income_models/confirm_income.dart';

ConfirmIncomeRequest _$ConfirmIncomeRequestFromJson(Map<String, dynamic> json) {
  return ConfirmIncomeRequest(
    code: json['code'] != null ? json['code'] as String : null,
    note: json['note'] != null ? json['note'] as String : null,
    images: json['images'] != null
        ? (json['images'] as List).map((e) => e as String).toList()
        : null,
    isComplaint: json['isComplaint'] != null
        ? json['isComplaint'] as bool
        : null,
    receivedProducts: json['receivedProducts'] != null
        ? (json['receivedProducts'] as List)
              .map((e) => Products.fromJson(e))
              .toList()
        : null,
    complaintNote: json['complaintNote'] != null
        ? json['complaintNote'] as String
        : null,
  );
}

Map<String, dynamic> _$ConfirmIncomeRequestToJson(
  ConfirmIncomeRequest instance,
) {
  Map<String, dynamic> json = {};

  if (instance.code != null) json['code'] = instance.code;
  if (instance.note != null) json['note'] = instance.note;
  if (instance.images != null) json['images'] = instance.images;
  if (instance.isComplaint != null) json['isComplaint'] = instance.isComplaint;
  if (instance.receivedProducts != null)
    json['receivedProducts'] = instance.receivedProducts;
  if (instance.complaintNote != null)
    json['complaintNote'] = instance.complaintNote;

  return json;
}
