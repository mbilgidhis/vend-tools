class PriceBookDetailsVend {
  Data? data;

  PriceBookDetailsVend({
    this.data});

  PriceBookDetailsVend.fromJson(dynamic json) {
    data = json["data"] != null ? Data.fromJson(json["data"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (data != null) {
      map["data"] = data?.toJson();
    }
    return map;
  }

}

class Data {
  int? version;
  dynamic deletedAt;
  String? customerGroupId;
  String? outletId;
  String? updatedAt;
  String? restrictToPlatformKey;
  String? restrictToPlatformLabel;
  String? validFrom;
  String? validTo;
  String? createdAt;
  String? name;
  String? id;
  String? type;

  Data({
    this.version,
    this.deletedAt,
    this.customerGroupId,
    this.outletId,
    this.updatedAt,
    this.restrictToPlatformKey,
    this.restrictToPlatformLabel,
    this.validFrom,
    this.validTo,
    this.createdAt,
    this.name,
    this.id,
    this.type});

  Data.fromJson(dynamic json) {
    version = json["version"];
    deletedAt = json["deleted_at"];
    customerGroupId = json["customer_group_id"];
    outletId = json["outlet_id"];
    updatedAt = json["updated_at"];
    restrictToPlatformKey = json["restrict_to_platform_key"];
    restrictToPlatformLabel = json["restrict_to_platform_label"];
    validFrom = json["valid_from"];
    validTo = json["valid_to"];
    createdAt = json["created_at"];
    name = json["name"];
    id = json["id"];
    type = json["type"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["version"] = version;
    map["deleted_at"] = deletedAt;
    map["customer_group_id"] = customerGroupId;
    map["outlet_id"] = outletId;
    map["updated_at"] = updatedAt;
    map["restrict_to_platform_key"] = restrictToPlatformKey;
    map["restrict_to_platform_label"] = restrictToPlatformLabel;
    map["valid_from"] = validFrom;
    map["valid_to"] = validTo;
    map["created_at"] = createdAt;
    map["name"] = name;
    map["id"] = id;
    map["type"] = type;
    return map;
  }

}

class Attributes {
  String? key;
  String? value;

  Attributes({
    this.key,
    this.value});

  Attributes.fromJson(dynamic json) {
    key = json["key"];
    value = json["value"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["key"] = key;
    map["value"] = value;
    return map;
  }

}