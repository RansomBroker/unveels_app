// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_to_cart_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddToCartResponse _$AddToCartResponseFromJson(Map<String, dynamic> json) =>
    AddToCartResponse(
      quoteId: (json['quoteId'] as num?)?.toInt(),
      isVirtual: json['isVirtual'] as bool?,
      minimumAmount: (json['minimumAmount'] as num?)?.toDouble(),
      minimumFormattedAmount: json['minimumFormattedAmount'] as String?,
      isCheckoutAllowed: json['isCheckoutAllowed'] as bool?,
      descriptionMessage: json['descriptionMessage'] as String?,
      isAllowedGuestCheckout: json['isAllowedGuestCheckout'] as bool?,
      canGuestCheckoutDownloadable:
          json['canGuestCheckoutDownloadable'] as bool?,
      cartTotal: (json['cartTotal'] as num?)?.toDouble(),
      cartTotalFormattedAmount: json['cartTotalFormattedAmount'] as String?,
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..otherError = json['otherError'] as String?
      ..redirect = json['redirect'] as String?
      ..eTag = json['eTag'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt()
      ..transferValidation = json['transferValidation'] as bool?;

Map<String, dynamic> _$AddToCartResponseToJson(AddToCartResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otherError': instance.otherError,
      'redirect': instance.redirect,
      'eTag': instance.eTag,
      'cartCount': instance.cartCount,
      'transferValidation': instance.transferValidation,
      'quoteId': instance.quoteId,
      'isVirtual': instance.isVirtual,
      'minimumAmount': instance.minimumAmount,
      'minimumFormattedAmount': instance.minimumFormattedAmount,
      'isCheckoutAllowed': instance.isCheckoutAllowed,
      'descriptionMessage': instance.descriptionMessage,
      'isAllowedGuestCheckout': instance.isAllowedGuestCheckout,
      'canGuestCheckoutDownloadable': instance.canGuestCheckoutDownloadable,
      'cartTotal': instance.cartTotal,
      'cartTotalFormattedAmount': instance.cartTotalFormattedAmount,
    };
