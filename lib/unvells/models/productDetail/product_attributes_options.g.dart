// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_attributes_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductAttributeOption _$ProductAttributeOptionFromJson(
        Map<String, dynamic> json) =>
    ProductAttributeOption(
      (json['id'] as num?)?.toInt(),
      json['label'] as String?,
      (json['products'] as List<dynamic>?)?.map((e) => e as String).toList(),
    )..swatchData = json['swatchData'] == null
        ? null
        : SwatchData.fromJson(json['swatchData'] as Map<String, dynamic>);

Map<String, dynamic> _$ProductAttributeOptionToJson(
        ProductAttributeOption instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'products': instance.products,
      'swatchData': instance.swatchData,
    };
