class ProductVend {
  dynamic includes;
  Data? data;

  ProductVend({
    this.includes,
    this.data});

  ProductVend.fromJson(dynamic json) {
    includes = json["includes"];
    data = json["data"] != null ? Data.fromJson(json["data"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["includes"] = includes;
    if (data != null) {
      map["data"] = data?.toJson();
    }
    return map;
  }

}

class Data {
  String? id;
  dynamic sourceId;
  dynamic sourceVariantId;
  dynamic variantParentId;
  String? name;
  String? variantName;
  String? handle;
  String? sku;
  String? supplierCode;
  bool? active;
  bool? hasInventory;
  bool? isComposite;
  String? description;
  String? imageUrl;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  String? source;
  dynamic accountCode;
  dynamic accountCodePurchase;
  double? supplyPrice;
  int? version;
  Type? type;
  Supplier? supplier;
  Brand? brand;
  List<VariantOptions>? variantOptions;
  List<Categories>? categories;
  List<dynamic>? images;
  bool? hasVariants;
  int? variantCount;
  int? buttonOrder;
  double? priceIncludingTax;
  double? priceExcludingTax;
  dynamic loyaltyAmount;
  List<ProductCodes>? productCodes;
  bool? isActive;
  String? imageThumbnailUrl;
  List<String>? tagIds;
  String? supplierId;
  String? productTypeId;
  String? brandId;
  List<dynamic>? attributes;

  Data({
    this.id,
    this.sourceId,
    this.sourceVariantId,
    this.variantParentId,
    this.name,
    this.variantName,
    this.handle,
    this.sku,
    this.supplierCode,
    this.active,
    this.hasInventory,
    this.isComposite,
    this.description,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.source,
    this.accountCode,
    this.accountCodePurchase,
    this.supplyPrice,
    this.version,
    this.type,
    this.supplier,
    this.brand,
    this.variantOptions,
    this.categories,
    this.images,
    this.hasVariants,
    this.variantCount,
    this.buttonOrder,
    this.priceIncludingTax,
    this.priceExcludingTax,
    this.loyaltyAmount,
    this.productCodes,
    this.isActive,
    this.imageThumbnailUrl,
    this.tagIds,
    this.supplierId,
    this.productTypeId,
    this.brandId,
    this.attributes});

  Data.fromJson(dynamic json) {
    id = json["id"];
    sourceId = json["source_id"];
    sourceVariantId = json["source_variant_id"];
    variantParentId = json["variant_parent_id"];
    name = json["name"];
    variantName = json["variant_name"];
    handle = json["handle"];
    sku = json["sku"];
    supplierCode = json["supplier_code"];
    active = json["active"];
    hasInventory = json["has_inventory"];
    isComposite = json["is_composite"];
    description = json["description"];
    imageUrl = json["image_url"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    deletedAt = json["deleted_at"];
    source = json["source"];
    accountCode = json["account_code"];
    accountCodePurchase = json["account_code_purchase"];
    supplyPrice = json["supply_price"];
    version = json["version"];
    type = json["type"] != null ? Type.fromJson(json["type"]) : null;
    supplier = json["supplier"] != null ? Supplier.fromJson(json["supplier"]) : null;
    brand = json["brand"] != null ? Brand.fromJson(json["brand"]) : null;
    if (json["variant_options"] != null) {
      variantOptions = [];
      json["variant_options"].forEach((v) {
        variantOptions?.add(VariantOptions.fromJson(v));
      });
    }
    if (json["categories"] != null) {
      categories = [];
      json["categories"].forEach((v) {
        categories?.add(Categories.fromJson(v));
      });
    }

    hasVariants = json["has_variants"];
    variantCount = json["variant_count"];
    buttonOrder = json["button_order"];
    priceIncludingTax = json["price_including_tax"];
    priceExcludingTax = json["price_excluding_tax"];
    loyaltyAmount = json["loyalty_amount"];
    if (json["product_codes"] != null) {
      productCodes = [];
      json["product_codes"].forEach((v) {
        productCodes?.add(ProductCodes.fromJson(v));
      });
    }
    isActive = json["is_active"];
    imageThumbnailUrl = json["image_thumbnail_url"];
    tagIds = json["tag_ids"] != null ? json["tag_ids"].cast<String>() : [];
    supplierId = json["supplier_id"];
    productTypeId = json["product_type_id"];
    brandId = json["brand_id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["source_id"] = sourceId;
    map["source_variant_id"] = sourceVariantId;
    map["variant_parent_id"] = variantParentId;
    map["name"] = name;
    map["variant_name"] = variantName;
    map["handle"] = handle;
    map["sku"] = sku;
    map["supplier_code"] = supplierCode;
    map["active"] = active;
    map["has_inventory"] = hasInventory;
    map["is_composite"] = isComposite;
    map["description"] = description;
    map["image_url"] = imageUrl;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    map["deleted_at"] = deletedAt;
    map["source"] = source;
    map["account_code"] = accountCode;
    map["account_code_purchase"] = accountCodePurchase;
    map["supply_price"] = supplyPrice;
    map["version"] = version;
    if (type != null) {
      map["type"] = type?.toJson();
    }
    if (supplier != null) {
      map["supplier"] = supplier?.toJson();
    }
    if (brand != null) {
      map["brand"] = brand?.toJson();
    }
    if (variantOptions != null) {
      map["variant_options"] = variantOptions?.map((v) => v.toJson()).toList();
    }
    if (categories != null) {
      map["categories"] = categories?.map((v) => v.toJson()).toList();
    }
    map["has_variants"] = hasVariants;
    map["variant_count"] = variantCount;
    map["button_order"] = buttonOrder;
    map["price_including_tax"] = priceIncludingTax;
    map["price_excluding_tax"] = priceExcludingTax;
    map["loyalty_amount"] = loyaltyAmount;
    if (productCodes != null) {
      map["product_codes"] = productCodes?.map((v) => v.toJson()).toList();
    }
    map["is_active"] = isActive;
    map["image_thumbnail_url"] = imageThumbnailUrl;
    map["tag_ids"] = tagIds;
    map["supplier_id"] = supplierId;
    map["product_type_id"] = productTypeId;
    map["brand_id"] = brandId;
    return map;
  }

}

class ProductCodes {
  String? id;
  String? type;
  String? code;

  ProductCodes({
    this.id,
    this.type,
    this.code});

  ProductCodes.fromJson(dynamic json) {
    id = json["id"];
    type = json["type"];
    code = json["code"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["type"] = type;
    map["code"] = code;
    return map;
  }

}

class Categories {
  String? id;
  String? name;
  dynamic deletedAt;
  int? version;

  Categories({
    this.id,
    this.name,
    this.deletedAt,
    this.version});

  Categories.fromJson(dynamic json) {
    id = json["id"];
    name = json["name"];
    deletedAt = json["deleted_at"];
    version = json["version"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    map["deleted_at"] = deletedAt;
    map["version"] = version;
    return map;
  }

}

class VariantOptions {
  String? id;
  String? name;
  String? value;

  VariantOptions({
    this.id,
    this.name,
    this.value});

  VariantOptions.fromJson(dynamic json) {
    id = json["id"];
    name = json["name"];
    value = json["value"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    map["value"] = value;
    return map;
  }

}

class Brand {
  String? id;
  String? name;
  dynamic deletedAt;
  int? version;

  Brand({
    this.id,
    this.name,
    this.deletedAt,
    this.version});

  Brand.fromJson(dynamic json) {
    id = json["id"];
    name = json["name"];
    deletedAt = json["deleted_at"];
    version = json["version"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    map["deleted_at"] = deletedAt;
    map["version"] = version;
    return map;
  }

}

class Supplier {
  String? id;
  String? name;
  String? source;
  dynamic description;
  dynamic deletedAt;
  int? version;

  Supplier({
    this.id,
    this.name,
    this.source,
    this.description,
    this.deletedAt,
    this.version});

  Supplier.fromJson(dynamic json) {
    id = json["id"];
    name = json["name"];
    source = json["source"];
    description = json["description"];
    deletedAt = json["deleted_at"];
    version = json["version"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    map["source"] = source;
    map["description"] = description;
    map["deleted_at"] = deletedAt;
    map["version"] = version;
    return map;
  }

}

class Type {
  String? id;
  String? name;
  dynamic deletedAt;
  int? version;

  Type({
    this.id,
    this.name,
    this.deletedAt,
    this.version});

  Type.fromJson(dynamic json) {
    id = json["id"];
    name = json["name"];
    deletedAt = json["deleted_at"];
    version = json["version"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    map["deleted_at"] = deletedAt;
    map["version"] = version;
    return map;
  }

}