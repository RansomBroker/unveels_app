// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wishlist_product_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WishlistProductRequest _$WishlistProductRequestFromJson(
        Map<String, dynamic> json) =>
    WishlistProductRequest(
      eTag: json['eTag'] as String?,
      storeId: json['storeId'] as String?,
      customerToken: json['customerToken'] as String?,
      currency: json['currency'] as String?,
      pageNumber: json['pageNumber'] as String?,
    );

Map<String, dynamic> _$WishlistProductRequestToJson(
        WishlistProductRequest instance) =>
    <String, dynamic>{
      'eTag': instance.eTag,
      'storeId': instance.storeId,
      'customerToken': instance.customerToken,
      'currency': instance.currency,
      'pageNumber': instance.pageNumber,
    };
