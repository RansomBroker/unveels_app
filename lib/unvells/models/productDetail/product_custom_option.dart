/*
 *


 *
 * /
 */

import 'package:json_annotation/json_annotation.dart';
import 'package:test_new/unvells/models/productDetail/swatch_data.dart';
part 'product_custom_option.g.dart';

@JsonSerializable()
class ProductCustomOption{

  @JsonKey(name: "option_id")
  String? optionId;

  @JsonKey(name: "product_id")
  String? productId;

  @JsonKey(name: "type")
  String? type;

  @JsonKey(name: "is_require")
  String? isRequire;

  @JsonKey(name: "sku")
  String? sku;

  @JsonKey(name: "max_characters")
  String? maxCharacters;

  @JsonKey(name: "file_extension")
  String? fileExtension;

  @JsonKey(name: "image_size_x")
  String? imageSizeX;

  @JsonKey(name: "image_size_y")
  String? imageSizeY;

  @JsonKey(name: "title")
  String? title;

  @JsonKey(name: "default_price")
  String? defaultPrice;

  @JsonKey(name: "price_type")
  String? priceType;

  @JsonKey(name: "unformatted_default_price")
  String? unformattedDefaultPrice;

  @JsonKey(name: "formatted_default_price")
  String? formattedDefaultPrice;

  @JsonKey(name:"optionValues")
  List<OptionValues>? optionValues;


  ProductCustomOption(
      {this.optionId,
      this.productId,
      this.type,
      this.isRequire,
      this.sku,
      this.maxCharacters,
      this.fileExtension,
      this.imageSizeX,
      this.imageSizeY,
      this.title,
      this.defaultPrice,
      this.priceType,
      this.unformattedDefaultPrice,
      this.formattedDefaultPrice,
      this.optionValues});

  factory ProductCustomOption.fromJson(Map<String, dynamic> json) =>
      _$ProductCustomOptionFromJson(json);

  Map<String, dynamic> toJson() => _$ProductCustomOptionToJson(this);
}

@JsonSerializable()
class OptionValues {
  @JsonKey(name:"option_type_id")
  String? optionTypeId;

  @JsonKey(name:"option_id")
  String? optionId;

  @JsonKey(name:"sku")
  String? sku;

  @JsonKey(name:"title")
  String? title;

  @JsonKey(name:"default_price")
  String? defaultPrice;

  @JsonKey(name:"default_price_type")
  String? defaultPriceType;

  @JsonKey(name:"price")
  String? price;

  @JsonKey(name:"price_type")
  String? priceType;

  @JsonKey(name:"formatted_default_price")
  String? formattedDefaultPrice;

  bool? isSelected;


  OptionValues(
      {this.optionTypeId,
      this.optionId,
      this.sku,
      this.title,
      this.defaultPrice,
      this.defaultPriceType,
      this.price,
      this.priceType,
      this.formattedDefaultPrice,
      this.isSelected
      });

  factory OptionValues.fromJson(Map<String, dynamic> json) =>
      _$OptionValuesFromJson(json);

  Map<String, dynamic> toJson() => _$OptionValuesToJson(this);
}