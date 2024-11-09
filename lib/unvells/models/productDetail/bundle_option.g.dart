// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bundle_option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BundleOption _$BundleOptionFromJson(Map<String, dynamic> json) => BundleOption(
      json['option_id'] as String?,
      json['parent_id'] as String?,
      json['required'] as String?,
      json['position'] as String?,
      json['type'] as String?,
      json['default_title'] as String?,
      json['title'] as String?,
      (json['optionValues'] as List<dynamic>?)
          ?.map((e) => OptionValue.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['selectedQty'] as String?,
      json['selectedOption'] as String?,
    );

Map<String, dynamic> _$BundleOptionToJson(BundleOption instance) =>
    <String, dynamic>{
      'option_id': instance.optionId,
      'parent_id': instance.parentId,
      'required': instance.required,
      'position': instance.position,
      'type': instance.type,
      'default_title': instance.defaultTitle,
      'title': instance.title,
      'selectedQty': instance.selectedQty,
      'selectedOption': instance.selectedOption,
      'optionValues': instance.optionValues,
    };
