part '../../parts/purchase_models/invoice.dart';

class Invoice {
  String? id;
  Invoice({this.id});
  static $fromJson(Map<String, dynamic> json) => _$InvoiceFromJson(json);

  factory Invoice.fromJson(Map<String, dynamic> json) =>
      _$InvoiceFromJson(json);
  Map<String, dynamic> toJson() => _$InvoiceToJson(this);
}
