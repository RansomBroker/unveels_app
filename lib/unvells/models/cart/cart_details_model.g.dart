// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartDetailsModel _$CartDetailsModelFromJson(Map<String, dynamic> json) =>
    CartDetailsModel(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => CartItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      couponCode: json['couponCode'] as String?,
      showThreshold: json['showThreshold'] as bool?,
      isVirtual: json['isVirtual'] as bool?,
      isAllowedGuestCheckout: json['isAllowedGuestCheckout'] as bool?,
      totalsData: (json['totalsData'] as List<dynamic>?)
          ?.map((e) => PriceDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
      crossSellList: (json['crossSellList'] as List<dynamic>?)
          ?.map((e) => ProductTileData.fromJson(e as Map<String, dynamic>))
          .toList(),
      canGuestCheckoutDownloadable:
          json['canGuestCheckoutDownloadable'] as bool?,
      allowMultipleShipping: json['allowMultipleShipping'] as bool?,
      isCheckoutAllowed: json['isCheckoutAllowed'] as bool?,
      minimumAmount: (json['minimumAmount'] as num?)?.toDouble(),
      minimumFormattedAmount: json['minimumFormattedAmount'] as String?,
      descriptionMessage: json['descriptionMessage'] as String?,
      cartTotal: json['cartTotal'] as String?,
      containsDownloadableProducts:
          json['containsDownloadableProducts'] as bool?,
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..otherError = json['otherError'] as String?
      ..redirect = json['redirect'] as String?
      ..eTag = json['eTag'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt()
      ..transferValidation = json['transferValidation'] as bool?;

Map<String, dynamic> _$CartDetailsModelToJson(CartDetailsModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otherError': instance.otherError,
      'redirect': instance.redirect,
      'eTag': instance.eTag,
      'cartCount': instance.cartCount,
      'transferValidation': instance.transferValidation,
      'items': instance.items,
      'couponCode': instance.couponCode,
      'showThreshold': instance.showThreshold,
      'isVirtual': instance.isVirtual,
      'isAllowedGuestCheckout': instance.isAllowedGuestCheckout,
      'totalsData': instance.totalsData,
      'crossSellList': instance.crossSellList,
      'canGuestCheckoutDownloadable': instance.canGuestCheckoutDownloadable,
      'allowMultipleShipping': instance.allowMultipleShipping,
      'isCheckoutAllowed': instance.isCheckoutAllowed,
      'minimumAmount': instance.minimumAmount,
      'minimumFormattedAmount': instance.minimumFormattedAmount,
      'descriptionMessage': instance.descriptionMessage,
      'cartTotal': instance.cartTotal,
      'containsDownloadableProducts': instance.containsDownloadableProducts,
    };
