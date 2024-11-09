// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'layered_data_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LayeredDataOptions _$LayeredDataOptionsFromJson(Map<String, dynamic> json) =>
    LayeredDataOptions(
      label: json['label'] as String?,
      id: json['id'] as String?,
      count: (json['count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$LayeredDataOptionsToJson(LayeredDataOptions instance) =>
    <String, dynamic>{
      'label': instance.label,
      'id': instance.id,
      'count': instance.count,
    };
