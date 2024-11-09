// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_datum.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressDatum _$AddressDatumFromJson(Map<String, dynamic> json) => AddressDatum(
      id: json['id'] as String?,
      addressTitle: json['addressTitle'] as String?,
      value: json['value'] as String?,
    );

Map<String, dynamic> _$AddressDatumToJson(AddressDatum instance) =>
    <String, dynamic>{
      'id': instance.id,
      'addressTitle': instance.addressTitle,
      'value': instance.value,
    };
