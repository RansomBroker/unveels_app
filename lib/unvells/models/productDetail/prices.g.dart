// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prices.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Prices _$PricesFromJson(Map<String, dynamic> json) => Prices(
      json['oldPrice'] == null
          ? null
          : Price.fromJson(json['oldPrice'] as Map<String, dynamic>),
      json['basePrice'] == null
          ? null
          : Price.fromJson(json['basePrice'] as Map<String, dynamic>),
      json['finalPrice'] == null
          ? null
          : Price.fromJson(json['finalPrice'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PricesToJson(Prices instance) => <String, dynamic>{
      'oldPrice': instance.oldPrice,
      'basePrice': instance.basePrice,
      'finalPrice': instance.finalPrice,
    };
