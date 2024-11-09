// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipping_address_datum.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShippingAddressDatum _$ShippingAddressDatumFromJson(
        Map<String, dynamic> json) =>
    ShippingAddressDatum(
      id: json['id'] as String?,
      addressTitle: json['addressTitle'] as String?,
      value: json['value'] as String?,
    );

Map<String, dynamic> _$ShippingAddressDatumToJson(
        ShippingAddressDatum instance) =>
    <String, dynamic>{
      'id': instance.id,
      'addressTitle': instance.addressTitle,
      'value': instance.value,
    };
