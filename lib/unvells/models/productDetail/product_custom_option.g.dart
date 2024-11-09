// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_custom_option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductCustomOption _$ProductCustomOptionFromJson(Map<String, dynamic> json) =>
    ProductCustomOption(
      optionId: json['option_id'] as String?,
      productId: json['product_id'] as String?,
      type: json['type'] as String?,
      isRequire: json['is_require'] as String?,
      sku: json['sku'] as String?,
      maxCharacters: json['max_characters'] as String?,
      fileExtension: json['file_extension'] as String?,
      imageSizeX: json['image_size_x'] as String?,
      imageSizeY: json['image_size_y'] as String?,
      title: json['title'] as String?,
      defaultPrice: json['default_price'] as String?,
      priceType: json['price_type'] as String?,
      unformattedDefaultPrice: json['unformatted_default_price'] as String?,
      formattedDefaultPrice: json['formatted_default_price'] as String?,
      optionValues: (json['optionValues'] as List<dynamic>?)
          ?.map((e) => OptionValues.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductCustomOptionToJson(
        ProductCustomOption instance) =>
    <String, dynamic>{
      'option_id': instance.optionId,
      'product_id': instance.productId,
      'type': instance.type,
      'is_require': instance.isRequire,
      'sku': instance.sku,
      'max_characters': instance.maxCharacters,
      'file_extension': instance.fileExtension,
      'image_size_x': instance.imageSizeX,
      'image_size_y': instance.imageSizeY,
      'title': instance.title,
      'default_price': instance.defaultPrice,
      'price_type': instance.priceType,
      'unformatted_default_price': instance.unformattedDefaultPrice,
      'formatted_default_price': instance.formattedDefaultPrice,
      'optionValues': instance.optionValues,
    };

OptionValues _$OptionValuesFromJson(Map<String, dynamic> json) => OptionValues(
      optionTypeId: json['option_type_id'] as String?,
      optionId: json['option_id'] as String?,
      sku: json['sku'] as String?,
      title: json['title'] as String?,
      defaultPrice: json['default_price'] as String?,
      defaultPriceType: json['default_price_type'] as String?,
      price: json['price'] as String?,
      priceType: json['price_type'] as String?,
      formattedDefaultPrice: json['formatted_default_price'] as String?,
      isSelected: json['isSelected'] as bool?,
    );

Map<String, dynamic> _$OptionValuesToJson(OptionValues instance) =>
    <String, dynamic>{
      'option_type_id': instance.optionTypeId,
      'option_id': instance.optionId,
      'sku': instance.sku,
      'title': instance.title,
      'default_price': instance.defaultPrice,
      'default_price_type': instance.defaultPriceType,
      'price': instance.price,
      'price_type': instance.priceType,
      'formatted_default_price': instance.formattedDefaultPrice,
      'isSelected': instance.isSelected,
    };
