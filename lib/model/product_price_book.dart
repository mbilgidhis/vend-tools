class ProductPriceBook {
  List<Data>? data;
  Version? version;

  ProductPriceBook({
    this.data,
    this.version});

  ProductPriceBook.fromJson(dynamic json) {
    if (json["data"] != null) {
      data = [];
      json["data"].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
    version = json["version"] != null ? Version.fromJson(json["version"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (data != null) {
      map["data"] = data?.map((v) => v.toJson()).toList();
    }
    if (version != null) {
      map["version"] = version?.toJson();
    }
    return map;
  }

}

class Version {
  int? min;
  int? max;

  Version({
    this.min,
    this.max});

  Version.fromJson(dynamic json) {
    min = json["min"];
    max = json["max"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["min"] = min;
    map["max"] = max;
    return map;
  }

}

class Data {
  String? id;
  String? productId;
  String? priceBookId;
  double? price;
  dynamic loyaltyValue;
  dynamic minUnits;
  dynamic maxUnits;
  int? version;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  Data({
    this.id,
    this.productId,
    this.priceBookId,
    this.price,
    this.loyaltyValue,
    this.minUnits,
    this.maxUnits,
    this.version,
    this.createdAt,
    this.updatedAt,
    this.deletedAt});

  Data.fromJson(dynamic json) {
    id = json["id"];
    productId = json["product_id"];
    priceBookId = json["price_book_id"];
    price = json["price"];
    loyaltyValue = json["loyalty_value"];
    minUnits = json["min_units"];
    maxUnits = json["max_units"];
    version = json["version"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    deletedAt = json["deleted_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["product_id"] = productId;
    map["price_book_id"] = priceBookId;
    map["price"] = price;
    map["loyalty_value"] = loyaltyValue;
    map["min_units"] = minUnits;
    map["max_units"] = maxUnits;
    map["version"] = version;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    map["deleted_at"] = deletedAt;
    return map;
  }

}