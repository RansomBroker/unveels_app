// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAddress _$GetAddressFromJson(Map<String, dynamic> json) => GetAddress(
      billingAddress: json['billingAddress'] == null
          ? null
          : BillingAddressDatum.fromJson(
              json['billingAddress'] as Map<String, dynamic>),
      shippingAddress: json['shippingAddress'] == null
          ? null
          : ShippingAddressDatum.fromJson(
              json['shippingAddress'] as Map<String, dynamic>),
      additionalAddress: (json['additionalAddress'] as List<dynamic>?)
          ?.map((e) => AddressDatum.fromJson(e as Map<String, dynamic>))
          .toList(),
      addressCount: (json['addressCount'] as num?)?.toInt(),
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..otherError = json['otherError'] as String?
      ..redirect = json['redirect'] as String?
      ..eTag = json['eTag'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt()
      ..transferValidation = json['transferValidation'] as bool?;

Map<String, dynamic> _$GetAddressToJson(GetAddress instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otherError': instance.otherError,
      'redirect': instance.redirect,
      'eTag': instance.eTag,
      'cartCount': instance.cartCount,
      'transferValidation': instance.transferValidation,
      'billingAddress': instance.billingAddress,
      'shippingAddress': instance.shippingAddress,
      'additionalAddress': instance.additionalAddress,
      'addressCount': instance.addressCount,
    };
