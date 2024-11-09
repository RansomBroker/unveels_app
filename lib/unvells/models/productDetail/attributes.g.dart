// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attributes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Attributes _$AttributesFromJson(Map<String, dynamic> json) => Attributes(
      json['code'] as String?,
      (json['id'] as num?)?.toInt(),
      json['label'] as String?,
      (json['options'] as List<dynamic>?)
          ?.map(
              (e) => ProductAttributeOption.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['position'] as String?,
      json['swatchData'] as String?,
      json['swatchType'] as String?,
      json['updateProductPreviewImage'] as bool?,
    );

Map<String, dynamic> _$AttributesToJson(Attributes instance) =>
    <String, dynamic>{
      'code': instance.code,
      'id': instance.id,
      'label': instance.label,
      'options': instance.options,
      'position': instance.position,
      'swatchData': instance.swatchData,
      'swatchType': instance.swatchType,
      'updateProductPreviewImage': instance.updateProductPreviewImage,
    };
