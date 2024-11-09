// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wishlist_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WishlistModel _$WishlistModelFromJson(Map<String, dynamic> json) =>
    WishlistModel(
      wishList: (json['wishList'] as List<dynamic>?)
          ?.map((e) => WishlistData.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: (json['totalCount'] as num?)?.toInt(),
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..otherError = json['otherError'] as String?
      ..redirect = json['redirect'] as String?
      ..eTag = json['eTag'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt()
      ..transferValidation = json['transferValidation'] as bool?;

Map<String, dynamic> _$WishlistModelToJson(WishlistModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otherError': instance.otherError,
      'redirect': instance.redirect,
      'eTag': instance.eTag,
      'cartCount': instance.cartCount,
      'transferValidation': instance.transferValidation,
      'wishList': instance.wishList,
      'totalCount': instance.totalCount,
    };

WishlistData _$WishlistDataFromJson(Map<String, dynamic> json) => WishlistData(
      id: json['id'] as String?,
      qty: (json['qty'] as num?)?.toInt(),
      sku: json['sku'] as String?,
      name: json['name'] as String?,
      price: json['price'],
      productId: json['productId'] as String?,
      thumbNail: json['thumbNail'] as String?,
      description: json['description'] as String?,
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => OptionsData.fromJson(e as Map<String, dynamic>))
          .toList(),
      reviewCount: (json['reviewCount'] as num?)?.toInt(),
      configurableData: json['configurableData'] == null
          ? null
          : ConfigurableData.fromJson(
              json['configurableData'] as Map<String, dynamic>),
      isInWishlist: json['isInWishlist'] as bool?,
      typeId: json['typeId'] as String?,
      entityId: (json['entityId'] as num?)?.toInt(),
      rating: json['rating'] as String?,
      isAvailable: json['isAvailable'] as bool?,
      finalPrice: json['finalPrice'] as String?,
      formattedPrice: json['formattedPrice'] as String?,
      formattedFinalPrice: json['formattedFinalPrice'] as String?,
      hasRequiredOptions: json['hasRequiredOptions'] as bool?,
      isNew: json['isNew'] as bool?,
      isInRange: json['isInRange'] as bool?,
      dominantColor: json['dominantColor'] as String?,
      tierPrice: json['tierPrice'] as String?,
      formattedTierPrice: json['formattedTierPrice'] as String?,
      minAddToCartQty: (json['minAddToCartQty'] as num?)?.toInt(),
      availability: json['availability'] as String?,
      arUrl: json['arUrl'] as String?,
      arType: json['arType'] as String?,
    );

Map<String, dynamic> _$WishlistDataToJson(WishlistData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'qty': instance.qty,
      'sku': instance.sku,
      'name': instance.name,
      'price': instance.price,
      'productId': instance.productId,
      'thumbNail': instance.thumbNail,
      'description': instance.description,
      'options': instance.options,
      'reviewCount': instance.reviewCount,
      'configurableData': instance.configurableData,
      'isInWishlist': instance.isInWishlist,
      'typeId': instance.typeId,
      'entityId': instance.entityId,
      'rating': instance.rating,
      'isAvailable': instance.isAvailable,
      'finalPrice': instance.finalPrice,
      'formattedPrice': instance.formattedPrice,
      'formattedFinalPrice': instance.formattedFinalPrice,
      'hasRequiredOptions': instance.hasRequiredOptions,
      'isNew': instance.isNew,
      'isInRange': instance.isInRange,
      'dominantColor': instance.dominantColor,
      'tierPrice': instance.tierPrice,
      'formattedTierPrice': instance.formattedTierPrice,
      'minAddToCartQty': instance.minAddToCartQty,
      'availability': instance.availability,
      'arUrl': instance.arUrl,
      'arType': instance.arType,
    };

OptionsData _$OptionsDataFromJson(Map<String, dynamic> json) => OptionsData(
      optionMessage: json['optionMessage'] as String?,
    );

Map<String, dynamic> _$OptionsDataToJson(OptionsData instance) =>
    <String, dynamic>{
      'optionMessage': instance.optionMessage,
    };

ConfigurableData _$ConfigurableDataFromJson(Map<String, dynamic> json) =>
    ConfigurableData(
      configurableMessage: json['configurableMessage'] as String?,
    );

Map<String, dynamic> _$ConfigurableDataToJson(ConfigurableData instance) =>
    <String, dynamic>{
      'configurableMessage': instance.configurableMessage,
    };

ArTextureImagesData _$ArTextureImagesDataFromJson(Map<String, dynamic> json) =>
    ArTextureImagesData(
      arTextureMessage: json['arTextureMessage'] as String?,
    );

Map<String, dynamic> _$ArTextureImagesDataToJson(
        ArTextureImagesData instance) =>
    <String, dynamic>{
      'arTextureMessage': instance.arTextureMessage,
    };
