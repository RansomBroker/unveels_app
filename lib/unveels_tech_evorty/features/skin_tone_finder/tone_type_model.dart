class ToneTypeModel {
  ExtensionAttributes? extensionAttributes;
  bool? isWysiwygEnabled;
  bool? isHtmlAllowedOnFront;
  bool? usedForSortBy;
  bool? isFilterable;
  bool? isFilterableInSearch;
  bool? isUsedInGrid;
  bool? isVisibleInGrid;
  bool? isFilterableInGrid;
  int? position;
  List<String>? applyTo;
  String? isSearchable;
  String? isVisibleInAdvancedSearch;
  String? isComparable;
  String? isUsedForPromoRules;
  String? isVisibleOnFront;
  String? usedInProductListing;
  bool? isVisible;
  String? scope;
  int? attributeId;
  String? attributeCode;
  String? frontendInput;
  String? entityTypeId;
  bool? isRequired;
  List<Options>? options;
  bool? isUserDefined;
  String? defaultFrontendLabel;
  List<FrontendLabels>? frontendLabels;
  String? backendType;
  String? backendModel;
  String? defaultValue;
  String? isUnique;
  List<String>? validationRules;

  ToneTypeModel(
      {this.extensionAttributes,
      this.isWysiwygEnabled,
      this.isHtmlAllowedOnFront,
      this.usedForSortBy,
      this.isFilterable,
      this.isFilterableInSearch,
      this.isUsedInGrid,
      this.isVisibleInGrid,
      this.isFilterableInGrid,
      this.position,
      this.applyTo,
      this.isSearchable,
      this.isVisibleInAdvancedSearch,
      this.isComparable,
      this.isUsedForPromoRules,
      this.isVisibleOnFront,
      this.usedInProductListing,
      this.isVisible,
      this.scope,
      this.attributeId,
      this.attributeCode,
      this.frontendInput,
      this.entityTypeId,
      this.isRequired,
      this.options,
      this.isUserDefined,
      this.defaultFrontendLabel,
      this.frontendLabels,
      this.backendType,
      this.backendModel,
      this.defaultValue,
      this.isUnique,
      this.validationRules});

  ToneTypeModel.fromJson(Map<String, dynamic> json) {
    extensionAttributes = json['extension_attributes'] != null
        ? ExtensionAttributes.fromJson(json['extension_attributes'])
        : null;
    isWysiwygEnabled = json['is_wysiwyg_enabled'];
    isHtmlAllowedOnFront = json['is_html_allowed_on_front'];
    usedForSortBy = json['used_for_sort_by'];
    isFilterable = json['is_filterable'];
    isFilterableInSearch = json['is_filterable_in_search'];
    isUsedInGrid = json['is_used_in_grid'];
    isVisibleInGrid = json['is_visible_in_grid'];
    isFilterableInGrid = json['is_filterable_in_grid'];
    position = json['position'];
    isSearchable = json['is_searchable'];
    isVisibleInAdvancedSearch = json['is_visible_in_advanced_search'];
    isComparable = json['is_comparable'];
    isUsedForPromoRules = json['is_used_for_promo_rules'];
    isVisibleOnFront = json['is_visible_on_front'];
    usedInProductListing = json['used_in_product_listing'];
    isVisible = json['is_visible'];
    scope = json['scope'];
    attributeId = json['attribute_id'];
    attributeCode = json['attribute_code'];
    frontendInput = json['frontend_input'];
    entityTypeId = json['entity_type_id'];
    isRequired = json['is_required'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(Options.fromJson(v));
      });
    }
    isUserDefined = json['is_user_defined'];
    defaultFrontendLabel = json['default_frontend_label'];
    if (json['frontend_labels'] != null) {
      frontendLabels = <FrontendLabels>[];
      json['frontend_labels'].forEach((v) {
        frontendLabels!.add(FrontendLabels.fromJson(v));
      });
    }
    backendType = json['backend_type'];
    backendModel = json['backend_model'];
    defaultValue = json['default_value'];
    isUnique = json['is_unique'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (extensionAttributes != null) {
      data['extension_attributes'] = extensionAttributes!.toJson();
    }
    data['is_wysiwyg_enabled'] = isWysiwygEnabled;
    data['is_html_allowed_on_front'] = isHtmlAllowedOnFront;
    data['used_for_sort_by'] = usedForSortBy;
    data['is_filterable'] = isFilterable;
    data['is_filterable_in_search'] = isFilterableInSearch;
    data['is_used_in_grid'] = isUsedInGrid;
    data['is_visible_in_grid'] = isVisibleInGrid;
    data['is_filterable_in_grid'] = isFilterableInGrid;
    data['position'] = position;
    data['is_searchable'] = isSearchable;
    data['is_visible_in_advanced_search'] = isVisibleInAdvancedSearch;
    data['is_comparable'] = isComparable;
    data['is_used_for_promo_rules'] = isUsedForPromoRules;
    data['is_visible_on_front'] = isVisibleOnFront;
    data['used_in_product_listing'] = usedInProductListing;
    data['is_visible'] = isVisible;
    data['scope'] = scope;
    data['attribute_id'] = attributeId;
    data['attribute_code'] = attributeCode;
    data['frontend_input'] = frontendInput;
    data['entity_type_id'] = entityTypeId;
    data['is_required'] = isRequired;
    if (options != null) {
      data['options'] = options!.map((v) => v.toJson()).toList();
    }
    data['is_user_defined'] = isUserDefined;
    data['default_frontend_label'] = defaultFrontendLabel;
    if (frontendLabels != null) {
      data['frontend_labels'] =
          frontendLabels!.map((v) => v.toJson()).toList();
    }
    data['backend_type'] = backendType;
    data['backend_model'] = backendModel;
    data['default_value'] = defaultValue;
    data['is_unique'] = isUnique;
    return data;
  }
}

class ExtensionAttributes {
  bool? isPagebuilderEnabled;

  ExtensionAttributes({this.isPagebuilderEnabled});

  ExtensionAttributes.fromJson(Map<String, dynamic> json) {
    isPagebuilderEnabled = json['is_pagebuilder_enabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['is_pagebuilder_enabled'] = isPagebuilderEnabled;
    return data;
  }
}

class Options {
  String? label;
  String? value;

  Options({this.label, this.value});

  Options.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    data['value'] = value;
    return data;
  }
}

class FrontendLabels {
  int? storeId;
  String? label;

  FrontendLabels({this.storeId, this.label});

  FrontendLabels.fromJson(Map<String, dynamic> json) {
    storeId = json['store_id'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['store_id'] = storeId;
    data['label'] = label;
    return data;
  }
}
