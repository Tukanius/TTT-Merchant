part of '../../models/sales_models/sales_model.dart';

Sales _$SalesFromJson(Map<String, dynamic> json) {
  return Sales(
    id: json['_id'] != null ? json['_id'] as String : null,
    isActive: json['isActive'] != null ? json['isActive'] as bool : null,
    isDeleted: json['isDeleted'] != null ? json['isDeleted'] as bool : null,
    isHidden: json['isHidden'] != null ? json['isHidden'] as bool : null,
    code: json['code'] != null ? json['code'] as String : null,
    description: json['description'] != null
        ? json['description'] as String
        : null,
    distributor: json['distributor'] != null
        ? Distributor.fromJson(json['distributor'])
        : null,
    toInventory: json['toInventory'] != null
        ? ToInventory.fromJson(json['toInventory'])
        : null,
    requestProduct: json['requestProduct'] != null
        ? (json['requestProduct'] as List)
              .map((e) => RequestProduct.fromJson(e))
              .toList()
        : null,
    weight: json['weight'] != null ? json['weight'] as int : null,
    requestType: json['requestType'] != null
        ? json['requestType'] as String
        : null,

    images: json['images'] != null
        ? (json['images'] as List).map((e) => e as String).toList()
        : null,
    user: json['user'] != null ? User.fromJson(json['user']) : null,

    deletedAt: json['deletedAt'] != null ? json['deletedAt'] as String : null,
    createdAt: json['createdAt'] != null ? json['createdAt'] as String : null,
    updatedAt: json['updatedAt'] != null ? json['updatedAt'] as String : null,
    fromInventory: json['fromInventory'] != null
        ? FromInventory.fromJson(json['fromInventory'])
        : null,

    totalCount: json['totalCount'] != null ? json['totalCount'] as int : null,
    saleType: json['saleType'] != null ? json['saleType'] as String : null,
    loadDate: json['loadDate'] != null ? json['loadDate'] as String : null,
    sendDate: json['sendDate'] != null ? json['sendDate'] as String : null,
    totalAmount: json['totalAmount'] != null
        ? json['totalAmount'] as int
        : null,
    requestStatus: json['requestStatus'] != null
        ? json['requestStatus'] as String
        : null,
  );
}

Map<String, dynamic> _$SalesToJson(Sales instance) {
  Map<String, dynamic> json = {};

  if (instance.id != null) json['_id'] = instance.id;
  if (instance.isActive != null) json['isActive'] = instance.isActive;
  if (instance.isDeleted != null) json['isDeleted'] = instance.isDeleted;
  if (instance.isHidden != null) json['isHidden'] = instance.isHidden;
  if (instance.code != null) json['code'] = instance.code;
  if (instance.description != null) json['description'] = instance.description;
  if (instance.distributor != null) json['distributor'] = instance.distributor;
  if (instance.toInventory != null) json['toInventory'] = instance.toInventory;
  if (instance.requestProduct != null)
    json['requestProduct'] = instance.requestProduct;
  if (instance.weight != null) json['weight'] = instance.weight;
  if (instance.requestType != null) json['requestType'] = instance.requestType;
  if (instance.images != null) json['images'] = instance.images;
  if (instance.user != null) json['user'] = instance.user;
  if (instance.deletedAt != null) json['deletedAt'] = instance.deletedAt;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;
  if (instance.updatedAt != null) json['updatedAt'] = instance.updatedAt;
  if (instance.fromInventory != null)
    json['fromInventory'] = instance.fromInventory;
  if (instance.totalCount != null) json['totalCount'] = instance.totalCount;
  if (instance.saleType != null) json['saleType'] = instance.saleType;
  if (instance.loadDate != null) json['loadDate'] = instance.loadDate;
  if (instance.sendDate != null) json['sendDate'] = instance.sendDate;
  if (instance.totalAmount != null) json['totalAmount'] = instance.totalAmount;
  if (instance.requestStatus != null)
    json['requestStatus'] = instance.requestStatus;

  return json;
}
