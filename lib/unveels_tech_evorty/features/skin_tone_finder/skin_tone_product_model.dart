class SkinToneProductModel {
  List<SkinToneProductData>? items;
  SearchCriteria? searchCriteria;
  int? totalCount;

  SkinToneProductModel({
    this.items,
    this.searchCriteria,
    this.totalCount,
  });

  factory SkinToneProductModel.fromJson(Map<dynamic, dynamic> json) {
    return SkinToneProductModel(
      items: List<SkinToneProductData>.from(
          json['items'].map((x) => SkinToneProductData.fromJson(x))),
      searchCriteria: SearchCriteria.fromJson(json['search_criteria']),
      totalCount: json['total_count'],
    );
  }
}

class SkinToneProductData {
  int id;
  dynamic sku;
  dynamic name;
  int attributeSetId;
  double price;
  int status;
  int visibility;
  dynamic typeId;
  dynamic createdAt;
  dynamic updatedAt;
  double weight;
  ExtensionAttributes extensionAttributes;
  List<ProductLink> productLinks;
  List<Option> options;
  List<MediaGalleryEntry> mediaGalleryEntries;
  List<TierPrice> tierPrices;
  List<CustomAttribute> customAttributes;

  SkinToneProductData({
    required this.id,
    required this.sku,
    required this.name,
    required this.attributeSetId,
    required this.price,
    required this.status,
    required this.visibility,
    required this.typeId,
    required this.createdAt,
    required this.updatedAt,
    required this.weight,
    required this.extensionAttributes,
    required this.productLinks,
    required this.options,
    required this.mediaGalleryEntries,
    required this.tierPrices,
    required this.customAttributes,
  });

  factory SkinToneProductData.fromJson(Map<dynamic, dynamic> json) {
    return SkinToneProductData(
      id: json['id'],
      sku: json['sku'],
      name: json['name'],
      attributeSetId: json['attribute_set_id'],
      price: json['price']?.toDouble() ?? 0.0,
      status: json['status'],
      visibility: json['visibility'],
      typeId: json['type_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      weight: json['weight']?.toDouble() ?? 0.0,
      extensionAttributes:
          ExtensionAttributes.fromJson(json['extension_attributes']),
      productLinks: List<ProductLink>.from(
          json['product_links'].map((x) => ProductLink.fromJson(x))),
      options:
          List<Option>.from(json['options'].map((x) => Option.fromJson(x))),
      mediaGalleryEntries: List<MediaGalleryEntry>.from(
          json['media_gallery_entries']
              .map((x) => MediaGalleryEntry.fromJson(x))),
      tierPrices: List<TierPrice>.from(
          json['tier_prices'].map((x) => TierPrice.fromJson(x))),
      customAttributes: List<CustomAttribute>.from(
          json['custom_attributes'].map((x) => CustomAttribute.fromJson(x))),
    );
  }
}

class ExtensionAttributes {
  List<int> websiteIds;
  List<CategoryLink> categoryLinks;

  ExtensionAttributes({
    required this.websiteIds,
    required this.categoryLinks,
  });

  factory ExtensionAttributes.fromJson(Map<dynamic, dynamic> json) {
    return ExtensionAttributes(
      websiteIds: List<int>.from(json['website_ids']),
      categoryLinks: List<CategoryLink>.from(
          json['category_links'].map((x) => CategoryLink.fromJson(x))),
    );
  }
}

class CategoryLink {
  int position;
  dynamic categoryId;

  CategoryLink({
    required this.position,
    required this.categoryId,
  });

  factory CategoryLink.fromJson(Map<dynamic, dynamic> json) {
    return CategoryLink(
      position: json['position'],
      categoryId: json['category_id'],
    );
  }
}

class MediaGalleryEntry {
  int id;
  dynamic mediaType;
  dynamic label;
  int position;
  bool disabled;
  List<dynamic> types;
  dynamic file;

  MediaGalleryEntry({
    required this.id,
    required this.mediaType,
    required this.label,
    required this.position,
    required this.disabled,
    required this.types,
    required this.file,
  });

  factory MediaGalleryEntry.fromJson(Map<dynamic, dynamic> json) {
    return MediaGalleryEntry(
      id: json['id'],
      mediaType: json['media_type'],
      label: json['label'],
      position: json['position'],
      disabled: json['disabled'],
      types: List<dynamic>.from(json['types']),
      file: json['file'],
    );
  }
}

class CustomAttribute {
  dynamic attributeCode;
  dynamic value;

  CustomAttribute({
    required this.attributeCode,
    required this.value,
  });

  factory CustomAttribute.fromJson(Map<dynamic, dynamic> json) {
    return CustomAttribute(
      attributeCode: json['attribute_code'],
      value: json['value'],
    );
  }
}

class SearchCriteria {
  List<FilterGroup> filterGroups;

  SearchCriteria({
    required this.filterGroups,
  });

  factory SearchCriteria.fromJson(Map<dynamic, dynamic> json) {
    return SearchCriteria(
      filterGroups: List<FilterGroup>.from(
          json['filter_groups'].map((x) => FilterGroup.fromJson(x))),
    );
  }
}

class FilterGroup {
  List<Filter> filters;

  FilterGroup({
    required this.filters,
  });

  factory FilterGroup.fromJson(Map<dynamic, dynamic> json) {
    return FilterGroup(
      filters:
          List<Filter>.from(json['filters'].map((x) => Filter.fromJson(x))),
    );
  }
}

class Filter {
  dynamic field;
  dynamic value;
  dynamic conditionType;

  Filter({
    required this.field,
    required this.value,
    required this.conditionType,
  });

  factory Filter.fromJson(Map<dynamic, dynamic> json) {
    return Filter(
      field: json['field'],
      value: json['value'],
      conditionType: json['condition_type'],
    );
  }
}

class ProductLink {
  // Define properties as needed
  ProductLink();

  factory ProductLink.fromJson(Map<dynamic, dynamic> json) {
    return ProductLink();
  }
}

class Option {
  // Define properties as needed
  Option();

  factory Option.fromJson(Map<dynamic, dynamic> json) {
    return Option();
  }
}

class TierPrice {
  // Define properties as needed
  TierPrice();

  factory TierPrice.fromJson(Map<dynamic, dynamic> json) {
    return TierPrice();
  }
}
