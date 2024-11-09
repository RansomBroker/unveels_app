// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_page_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryPageResponse _$CategoryPageResponseFromJson(
        Map<String, dynamic> json) =>
    CategoryPageResponse(
      (json['categories'] as List<dynamic>?)
          ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['productList'] as List<dynamic>?)
          ?.map((e) => ProductTileData.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['hotSeller'] as List<dynamic>?)
          ?.map((e) => ProductTileData.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['bannerImage'] as List<dynamic>?)
          ?.map((e) => BannerImages.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['smallBannerImage'] as List<dynamic>?)
          ?.map((e) => BannerImages.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..otherError = json['otherError'] as String?
      ..redirect = json['redirect'] as String?
      ..eTag = json['eTag'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt()
      ..transferValidation = json['transferValidation'] as bool?;

Map<String, dynamic> _$CategoryPageResponseToJson(
        CategoryPageResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otherError': instance.otherError,
      'redirect': instance.redirect,
      'eTag': instance.eTag,
      'cartCount': instance.cartCount,
      'transferValidation': instance.transferValidation,
      'categories': instance.categories,
      'productList': instance.productList,
      'hotSeller': instance.hotSeller,
      'bannerImage': instance.bannerImage,
      'smallBannerImage': instance.smallBannerImage,
    };
