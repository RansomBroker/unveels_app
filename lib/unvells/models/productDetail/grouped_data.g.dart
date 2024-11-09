// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grouped_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupedData _$GroupedDataFromJson(Map<String, dynamic> json) => GroupedData(
      json['name'] as String?,
      json['id'] as String?,
      json['isAvailable'] as bool?,
      json['isInRange'] as bool?,
      json['specialPrice'] as String?,
      (json['defaultQty'] as num?)?.toInt(),
      json['foramtedPrice'] as String?,
      json['thumbNail'] as String?,
    );

Map<String, dynamic> _$GroupedDataToJson(GroupedData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'isAvailable': instance.isAvailable,
      'isInRange': instance.isInRange,
      'specialPrice': instance.specialPrice,
      'defaultQty': instance.defaultQty,
      'foramtedPrice': instance.foramtedPrice,
      'thumbNail': instance.thumbNail,
    };
