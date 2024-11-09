// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_format.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceFormat _$PriceFormatFromJson(Map<String, dynamic> json) => PriceFormat(
      json['pattern'] as String?,
      (json['precision'] as num?)?.toInt(),
      (json['requiredPrecision'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PriceFormatToJson(PriceFormat instance) =>
    <String, dynamic>{
      'pattern': instance.pattern,
      'precision': instance.precision,
      'requiredPrecision': instance.requiredPrecision,
    };
