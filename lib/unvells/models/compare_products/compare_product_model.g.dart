// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'compare_product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompareProductModel _$CompareProductModelFromJson(Map<String, dynamic> json) =>
    CompareProductModel(
      attributeValueList: (json['attributeValueList'] as List<dynamic>?)
          ?.map((e) => AttributeValue.fromJson(e as Map<String, dynamic>))
          .toList(),
      productList: (json['productList'] as List<dynamic>?)
          ?.map((e) => ProductTileData.fromJson(e as Map<String, dynamic>))
          .toList(),
      showSwatchOnCollection: json['showSwatchOnCollection'] as bool?,
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..otherError = json['otherError'] as String?
      ..redirect = json['redirect'] as String?
      ..eTag = json['eTag'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt()
      ..transferValidation = json['transferValidation'] as bool?;

Map<String, dynamic> _$CompareProductModelToJson(
        CompareProductModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otherError': instance.otherError,
      'redirect': instance.redirect,
      'eTag': instance.eTag,
      'cartCount': instance.cartCount,
      'transferValidation': instance.transferValidation,
      'showSwatchOnCollection': instance.showSwatchOnCollection,
      'productList': instance.productList,
      'attributeValueList': instance.attributeValueList,
    };

AttributeValue _$AttributeValueFromJson(Map<String, dynamic> json) =>
    AttributeValue(
      value:
          (json['value'] as List<dynamic>?)?.map((e) => e as String).toList(),
      attributeName: json['attributeName'] as String?,
    );

Map<String, dynamic> _$AttributeValueToJson(AttributeValue instance) =>
    <String, dynamic>{
      'attributeName': instance.attributeName,
      'value': instance.value,
    };
