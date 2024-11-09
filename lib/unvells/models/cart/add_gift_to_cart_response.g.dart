// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_gift_to_cart_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cart _$CartFromJson(Map<String, dynamic> json) => Cart(
      total_quantity: (json['total_quantity'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CartToJson(Cart instance) => <String, dynamic>{
      'total_quantity': instance.total_quantity,
    };

AddGiftToCartResponse _$AddGiftToCartResponseFromJson(
        Map<String, dynamic> json) =>
    AddGiftToCartResponse(
      cart: json['cart'] == null
          ? null
          : Cart.fromJson(json['cart'] as Map<String, dynamic>),
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..otherError = json['otherError'] as String?
      ..redirect = json['redirect'] as String?
      ..eTag = json['eTag'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt()
      ..transferValidation = json['transferValidation'] as bool?;

Map<String, dynamic> _$AddGiftToCartResponseToJson(
        AddGiftToCartResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otherError': instance.otherError,
      'redirect': instance.redirect,
      'eTag': instance.eTag,
      'cartCount': instance.cartCount,
      'transferValidation': instance.transferValidation,
      'cart': instance.cart,
    };
