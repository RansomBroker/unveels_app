// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'advance_search_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdvanceSearchModel _$AdvanceSearchModelFromJson(Map<String, dynamic> json) =>
    AdvanceSearchModel(
      fieldList: (json['fieldList'] as List<dynamic>?)
          ?.map((e) => FieldList.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..otherError = json['otherError'] as String?
      ..redirect = json['redirect'] as String?
      ..eTag = json['eTag'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt()
      ..transferValidation = json['transferValidation'] as bool?;

Map<String, dynamic> _$AdvanceSearchModelToJson(AdvanceSearchModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otherError': instance.otherError,
      'redirect': instance.redirect,
      'eTag': instance.eTag,
      'cartCount': instance.cartCount,
      'transferValidation': instance.transferValidation,
      'fieldList': instance.fieldList,
    };

FieldList _$FieldListFromJson(Map<String, dynamic> json) => FieldList(
      label: json['label'] as String?,
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => Options.fromJson(e as Map<String, dynamic>))
          .toList(),
      title: json['title'] as String?,
      attributeCode: json['attributeCode'] as String?,
      inputType: json['inputType'] as String?,
      maxQueryLength: json['maxQueryLength'] as String?,
      value: json['value'],
    );

Map<String, dynamic> _$FieldListToJson(FieldList instance) => <String, dynamic>{
      'label': instance.label,
      'title': instance.title,
      'inputType': instance.inputType,
      'attributeCode': instance.attributeCode,
      'maxQueryLength': instance.maxQueryLength,
      'options': instance.options,
      'value': instance.value,
    };

Options _$OptionsFromJson(Map<String, dynamic> json) => Options(
      label: json['label'] as String?,
      value: json['value'] as String?,
      isSelected: json['isSelected'] as bool?,
    );

Map<String, dynamic> _$OptionsToJson(Options instance) => <String, dynamic>{
      'value': instance.value,
      'label': instance.label,
      'isSelected': instance.isSelected,
    };
