// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipping_address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShippingAddressModel _$ShippingAddressModelFromJson(
        Map<String, dynamic> json) =>
    ShippingAddressModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      cartCount: (json['cartCount'] as num?)?.toInt(),
      address: (json['address'] as List<dynamic>?)
          ?.map((e) => Address.fromJson(e as Map<String, dynamic>))
          .toList(),
      allowToChooseState: json['allowToChooseState'] as bool?,
      defaultCountry: json['defaultCountry'] as String?,
      firstName: json['firstName'] as String?,
      isVirtual: json['isVirtual'] as bool?,
      lastName: json['lastName'] as String?,
      middleName: json['middleName'] as String?,
      prefixValue: json['prefixValue'] as String?,
      streetLineCount: (json['streetLineCount'] as num?)?.toInt(),
      suffixValue: json['suffixValue'] as String?,
    )
      ..selectedAddressData = json['selectedAddressData'] == null
          ? null
          : Address.fromJson(
              json['selectedAddressData'] as Map<String, dynamic>)
      ..hasNewAddress = json['hasNewAddress'] as bool?;

Map<String, dynamic> _$ShippingAddressModelToJson(
        ShippingAddressModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'lastName': instance.lastName,
      'firstName': instance.firstName,
      'middleName': instance.middleName,
      'prefixValue': instance.prefixValue,
      'suffixValue': instance.suffixValue,
      'cartCount': instance.cartCount,
      'isVirtual': instance.isVirtual,
      'streetLineCount': instance.streetLineCount,
      'defaultCountry': instance.defaultCountry,
      'allowToChooseState': instance.allowToChooseState,
      'address': instance.address,
      'selectedAddressData': instance.selectedAddressData,
      'hasNewAddress': instance.hasNewAddress,
    };

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      value: json['value'] as String?,
      id: json['id'] as String?,
      isNew: json['isNew'] as bool?,
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'value': instance.value,
      'id': instance.id,
      'isNew': instance.isNew,
    };
