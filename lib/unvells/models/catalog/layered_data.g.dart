// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'layered_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LayeredData _$LayeredDataFromJson(Map<String, dynamic> json) => LayeredData(
      label: json['label'] as String?,
      code: json['code'] as String?,
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => LayeredDataOptions.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LayeredDataToJson(LayeredData instance) =>
    <String, dynamic>{
      'label': instance.label,
      'code': instance.code,
      'options': instance.options,
    };
