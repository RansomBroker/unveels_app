// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders_and_returns_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrdersAndReturnsModel _$OrdersAndReturnsModelFromJson(
        Map<String, dynamic> json) =>
    OrdersAndReturnsModel(
      email: json['email'] as String?,
      orderId: json['orderId'] as String?,
      billingLastName: json['billingLastName'] as String?,
      findOrderBy: json['findOrderBy'] as String?,
      billingZipCode: json['billingZipCode'] as String?,
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..otherError = json['otherError'] as String?
      ..redirect = json['redirect'] as String?
      ..eTag = json['eTag'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt()
      ..transferValidation = json['transferValidation'] as bool?;

Map<String, dynamic> _$OrdersAndReturnsModelToJson(
        OrdersAndReturnsModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otherError': instance.otherError,
      'redirect': instance.redirect,
      'eTag': instance.eTag,
      'cartCount': instance.cartCount,
      'transferValidation': instance.transferValidation,
      'email': instance.email,
      'orderId': instance.orderId,
      'billingLastName': instance.billingLastName,
      'findOrderBy': instance.findOrderBy,
      'billingZipCode': instance.billingZipCode,
    };
