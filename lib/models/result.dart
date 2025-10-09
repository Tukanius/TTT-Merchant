part '../parts/result.dart';

class Filter {
  String? date;
  String? dateType;
  String? status;
  String? type;
  String? query;
  String? startDate;
  String? endDate;
  String? requestStatus;
  String? inOutType;
  String? receiptStatus;
  String? listtype;

  Filter({
    this.date,
    this.dateType,
    this.status,
    this.type,
    this.query,
    this.startDate,
    this.endDate,
    this.requestStatus,
    this.inOutType,
    this.receiptStatus,
    this.listtype,
  });
}

class Offset {
  int? page;
  int? limit;

  Offset({this.page, this.limit});
}

class ResultArguments {
  Filter? filter = Filter();
  Offset? offset = Offset();
  int? page;
  int? limit;
  String? type;
  String? status;
  List<List<double>>? bounds;
  String? query;
  String? level1;
  String? startDate;
  String? endDate;
  int? personCountMax;
  int? personCountMin;
  String? property;
  bool? ignoreBounds;
  List<String>? tags;
  int? priceMin;
  int? priceMax;
  List<String>? placeOffers;
  int? levels1;
  int? levels2;
  String? category;
  String? parent;

  ResultArguments({
    this.filter,
    this.offset,
    this.limit,
    this.page,
    this.type,
    this.bounds,
    this.status,
    this.query,
    this.startDate,
    this.endDate,
    this.level1,
    this.personCountMax,
    this.personCountMin,
    this.property,
    this.ignoreBounds,
    this.tags,
    this.priceMin,
    this.priceMax,
    this.placeOffers,
    this.levels1,
    this.levels2,
    this.category,
    this.parent,
  });

  Map<String, dynamic> toJson() => _$ResultArgumentToJson(this);
}

class Result {
  List<dynamic>? rows = [];
  int? count = 0;
  List<dynamic>? totals = [];

  Result({this.rows, this.count, this.totals});

  factory Result.fromJson(dynamic json, Function fromJson) =>
      _$ResultFromJson(json, fromJson);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}
