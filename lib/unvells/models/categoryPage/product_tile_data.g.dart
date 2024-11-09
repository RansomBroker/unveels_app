// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_tile_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductTileData _$ProductTileDataFromJson(Map<String, dynamic> json) =>
    ProductTileData(
      json['availability'] as String?,
      json['dominantColor'] as String?,
      (json['entityId'] as num?)?.toInt(),
      json['finalPrice'] as String,
      json['formattedFinalPrice'] as String?,
      json['formattedPrice'] as String?,
      json['formattedTierPrice'] as String?,
      json['hasRequiredOptions'] as bool,
      json['isAvailable'] as bool?,
      json['isInRange'] as bool?,
      json['isInWishlist'] as bool?,
      json['isNew'] as bool?,
      (json['minAddToCartQty'] as num?)?.toInt(),
      json['name'] as String?,
      json['price'] as String?,
      (json['reviewCount'] as num?)?.toInt(),
      json['thumbNail'] as String?,
      json['tierPrice'] as String?,
      json['typeId'] as String?,
      json['rating'],
      (json['wishlistItemId'] as num?)?.toInt(),
    )..isChecked = json['isChecked'] as bool?;

Map<String, dynamic> _$ProductTileDataToJson(ProductTileData instance) =>
    <String, dynamic>{
      'availability': instance.availability,
      'dominantColor': instance.dominantColor,
      'entityId': instance.entityId,
      'finalPrice': instance.finalPrice,
      'formattedFinalPrice': instance.formattedFinalPrice,
      'formattedPrice': instance.formattedPrice,
      'formattedTierPrice': instance.formattedTierPrice,
      'hasRequiredOptions': instance.hasRequiredOptions,
      'isAvailable': instance.isAvailable,
      'isInRange': instance.isInRange,
      'isInWishlist': instance.isInWishlist,
      'isNew': instance.isNew,
      'minAddToCartQty': instance.minAddToCartQty,
      'name': instance.name,
      'price': instance.price,
      'reviewCount': instance.reviewCount,
      'thumbNail': instance.thumbNail,
      'tierPrice': instance.tierPrice,
      'typeId': instance.typeId,
      'rating': instance.rating,
      'wishlistItemId': instance.wishlistItemId,
      'isChecked': instance.isChecked,
    };
