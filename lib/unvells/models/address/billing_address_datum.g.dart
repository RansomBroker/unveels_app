// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'billing_address_datum.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BillingAddressDatum _$BillingAddressDatumFromJson(Map<String, dynamic> json) =>
    BillingAddressDatum(
      id: json['id'] as String?,
      addressTitle: json['addressTitle'] as String?,
      value: json['value'] as String?,
    );

Map<String, dynamic> _$BillingAddressDatumToJson(
        BillingAddressDatum instance) =>
    <String, dynamic>{
      'id': instance.id,
      'addressTitle': instance.addressTitle,
      'value': instance.value,
    };
