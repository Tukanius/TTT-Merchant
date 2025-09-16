part of '../models/result.dart';

Result _$ResultFromJson(dynamic res, Function fromJson) {
  Map<String, dynamic>? json;
  List<dynamic>? results;

  if (res.runtimeType == <dynamic>[].runtimeType) {
    results = res as List?;

    return Result(
      rows: results!
          .map((json) => fromJson(json as Map<String, dynamic>))
          .toList(),
      count: results.length,
    );
  } else {
    json = res as Map<String, dynamic>?;
    return Result(
      rows: (json!['rows'] as List)
          .map((json) => fromJson(json as Map<String, dynamic>))
          .toList(),
      count: json['count'] as int?,
    );
  }
}

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
  'rows': instance.rows,
  'count': instance.count,
};

Map<String, dynamic> _$ResultArgumentToJson(ResultArguments? instance) {
  Map<String, dynamic> params = {};

  if (instance != null) {
    print('=test======');

    print(instance.filter?.dateType);
    print(instance.offset?.page);
    print(instance.offset!.limit);
    print('=test======');
    if (instance.filter != null) {
      params['filter'] ??= {}; // хоосон map оноож өгнө
      if (instance.filter!.date != null && instance.filter!.date != '') {
        params['filter']['date'] = instance.filter!.date;
      } else {
        params['filter']['date'] = [];
      }
    }
    if (instance.filter != null) {
      params['filter'] ??= {};
      if (instance.filter!.type != null && instance.filter!.type != '') {
        params['filter']['type'] = instance.filter!.type;
      } else {
        params['filter']['type'] = [];
      }
    }
    if (instance.filter != null) {
      params['filter'] ??= {}; // хоосон map оноож өгнө
      if (instance.filter!.status != null && instance.filter!.status != '') {
        params['filter']['status'] = instance.filter!.status;
      } else {
        params['filter']['status'] = [];
      }
    }
    if (instance.filter != null) {
      params['filter'] ??= {};
      if (instance.filter!.dateType != null &&
          instance.filter!.dateType != '') {
        params['filter']['dateType'] = instance.filter!.dateType;
      } else {
        params['filter']['dateType'] = [];
      }
    }
    if (instance.filter != null) {
      params['filter'] ??= {};
      if (instance.filter!.query != null && instance.filter!.query != '') {
        params['filter']['query'] = instance.filter!.query;
      } else {
        params['filter']['query'] = [];
      }
    }
    if (instance.page != null && instance.page! > 0) {
      params['page'] = instance.page;
    }

    if (instance.limit != null && instance.limit! > 0) {
      params['limit'] = instance.limit;
    }
    if (instance.type != null) {
      params['type'] = instance.type;
    }
    if (instance.query != null) {
      params['query'] = instance.query;
    }
    if (instance.status != null) {
      params['status'] = instance.status;
    }

    if (instance.offset != null &&
        instance.offset!.page != null &&
        instance.offset!.page! > 0) {
      params['offset'] ??= {};
      params['offset']['page'] = instance.offset!.page;
    }

    if (instance.offset != null &&
        instance.offset!.limit != null &&
        instance.offset!.limit! > 0) {
      params['offset'] ??= {};
      params['offset']['limit'] = instance.offset!.limit;
    }
    if (instance.bounds != null && instance.bounds!.isNotEmpty) {
      for (int i = 0; i < instance.bounds!.length; i++) {
        for (int j = 0; j < instance.bounds![i].length; j++) {
          params['bounds[$i][$j]'] = instance.bounds![i][j];
        }
      }
    }
    if (instance.level1 != null) {
      params['level1'] = instance.level1;
    }
    if (instance.property != null) {
      params['property'] = instance.property;
    }
    if (instance.startDate != null) {
      params['startDate'] = instance.startDate;
    }
    if (instance.endDate != null) {
      params['endDate'] = instance.endDate;
    }
    if (instance.personCountMax != null) {
      params['personCount[max]'] = instance.personCountMax;
    }
    if (instance.personCountMin != null) {
      params['personCount[min]'] = instance.personCountMin;
    }
    if (instance.ignoreBounds != null) {
      params['ignoreBounds'] = instance.ignoreBounds;
    }
    if (instance.tags != null && instance.tags!.isNotEmpty) {
      for (int i = 0; i < instance.tags!.length; i++) {
        params['tags[$i]'] = instance.tags![i];
      }
    }
    if (instance.priceMin != null) {
      params['priceMin'] = instance.priceMin;
    }
    if (instance.priceMax != null) {
      params['priceMax'] = instance.priceMax;
    }
    if (instance.levels1 != null) {
      params['levels[0]'] = instance.levels1;
    }
    if (instance.levels2 != null) {
      params['levels[1]'] = instance.levels2;
    }
    if (instance.category != null) {
      params['category'] = instance.category;
    }
    if (instance.parent != null) {
      params['parent'] = instance.parent;
    }
    if (instance.placeOffers != null && instance.placeOffers!.isNotEmpty) {
      for (int i = 0; i < instance.placeOffers!.length; i++) {
        params['placeOffers[$i]'] = instance.placeOffers![i];
      }
    }
  }

  return params;
}
