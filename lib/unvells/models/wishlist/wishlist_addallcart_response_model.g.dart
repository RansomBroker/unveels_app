// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wishlist_addallcart_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WishlistAddallcartResponseModel _$WishlistAddallcartResponseModelFromJson(
        Map<String, dynamic> json) =>
    WishlistAddallcartResponseModel(
      data: json['data'] == null
          ? null
          : WishlistAddAllData.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..otherError = json['otherError'] as String?
      ..redirect = json['redirect'] as String?
      ..eTag = json['eTag'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt()
      ..transferValidation = json['transferValidation'] as bool?;

Map<String, dynamic> _$WishlistAddallcartResponseModelToJson(
        WishlistAddallcartResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otherError': instance.otherError,
      'redirect': instance.redirect,
      'eTag': instance.eTag,
      'cartCount': instance.cartCount,
      'transferValidation': instance.transferValidation,
      'data': instance.data,
    };

WishlistAddAllData _$WishlistAddAllDataFromJson(Map<String, dynamic> json) =>
    WishlistAddAllData(
      allToCart: json['allToCart'] == null
          ? null
          : WishlistAddAllToCart.fromJson(
              json['allToCart'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WishlistAddAllDataToJson(WishlistAddAllData instance) =>
    <String, dynamic>{
      'allToCart': instance.allToCart,
    };

WishlistAddAllToCart _$WishlistAddAllToCartFromJson(
        Map<String, dynamic> json) =>
    WishlistAddAllToCart(
      warning: json['warning'] as String?,
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..otherError = json['otherError'] as String?
      ..redirect = json['redirect'] as String?
      ..eTag = json['eTag'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt()
      ..transferValidation = json['transferValidation'] as bool?;

Map<String, dynamic> _$WishlistAddAllToCartToJson(
        WishlistAddAllToCart instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otherError': instance.otherError,
      'redirect': instance.redirect,
      'eTag': instance.eTag,
      'cartCount': instance.cartCount,
      'transferValidation': instance.transferValidation,
      'warning': instance.warning,
    };
