// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'option_prices.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OptionPrices _$OptionPricesFromJson(Map<String, dynamic> json) => OptionPrices(
      json['oldPrice'] == null
          ? null
          : Price.fromJson(json['oldPrice'] as Map<String, dynamic>),
      json['basePrice'] == null
          ? null
          : Price.fromJson(json['basePrice'] as Map<String, dynamic>),
      json['finalPrice'] == null
          ? null
          : Price.fromJson(json['finalPrice'] as Map<String, dynamic>),
      json['tierPrices'] == null
          ? null
          : Price.fromJson(json['tierPrices'] as Map<String, dynamic>),
      (json['product'] as num?)?.toInt(),
    );

Map<String, dynamic> _$OptionPricesToJson(OptionPrices instance) =>
    <String, dynamic>{
      'oldPrice': instance.oldPrice,
      'basePrice': instance.basePrice,
      'finalPrice': instance.finalPrice,
      'tierPrices': instance.tierPrices,
      'product': instance.product,
    };
