// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wishlist_movecart_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WishlistMovecartResponseModel _$WishlistMovecartResponseModelFromJson(
        Map<String, dynamic> json) =>
    WishlistMovecartResponseModel(
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

Map<String, dynamic> _$WishlistMovecartResponseModelToJson(
        WishlistMovecartResponseModel instance) =>
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
      wishlistToCart: json['wishlistToCart'] == null
          ? null
          : WishlistToCart.fromJson(
              json['wishlistToCart'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WishlistAddAllDataToJson(WishlistAddAllData instance) =>
    <String, dynamic>{
      'wishlistToCart': instance.wishlistToCart,
    };

WishlistToCart _$WishlistToCartFromJson(Map<String, dynamic> json) =>
    WishlistToCart()
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..otherError = json['otherError'] as String?
      ..redirect = json['redirect'] as String?
      ..eTag = json['eTag'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt()
      ..transferValidation = json['transferValidation'] as bool?;

Map<String, dynamic> _$WishlistToCartToJson(WishlistToCart instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otherError': instance.otherError,
      'redirect': instance.redirect,
      'eTag': instance.eTag,
      'cartCount': instance.cartCount,
      'transferValidation': instance.transferValidation,
    };
