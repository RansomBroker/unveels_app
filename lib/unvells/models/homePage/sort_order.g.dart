// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sort_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SortOrder _$SortOrderFromJson(Map<String, dynamic> json) => SortOrder(
      id: (json['id'] as num?)?.toInt(),
      layoutId: json['layoutId'] as String?,
      label: json['label'] as String?,
      position: json['position'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$SortOrderToJson(SortOrder instance) => <String, dynamic>{
      'id': instance.id,
      'layoutId': instance.layoutId,
      'label': instance.label,
      'position': instance.position,
      'type': instance.type,
    };
