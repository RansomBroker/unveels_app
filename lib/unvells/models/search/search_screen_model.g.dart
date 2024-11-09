// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_screen_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchScreenModel _$SearchScreenModelFromJson(Map<String, dynamic> json) =>
    SearchScreenModel(
      suggestProductArray: json['suggestProductArray'] == null
          ? null
          : SuggestProduct.fromJson(
              json['suggestProductArray'] as Map<String, dynamic>),
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..otherError = json['otherError'] as String?
      ..redirect = json['redirect'] as String?
      ..eTag = json['eTag'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt()
      ..transferValidation = json['transferValidation'] as bool?;

Map<String, dynamic> _$SearchScreenModelToJson(SearchScreenModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otherError': instance.otherError,
      'redirect': instance.redirect,
      'eTag': instance.eTag,
      'cartCount': instance.cartCount,
      'transferValidation': instance.transferValidation,
      'suggestProductArray': instance.suggestProductArray,
    };

SuggestProduct _$SuggestProductFromJson(Map<String, dynamic> json) =>
    SuggestProduct(
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
      tags: (json['tags'] as List<dynamic>?)
          ?.map((e) => Tags.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SuggestProductToJson(SuggestProduct instance) =>
    <String, dynamic>{
      'tags': instance.tags,
      'products': instance.products,
    };

Tags _$TagsFromJson(Map<String, dynamic> json) => Tags(
      label: json['label'] as String?,
      count: (json['count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TagsToJson(Tags instance) => <String, dynamic>{
      'label': instance.label,
      'count': instance.count,
    };

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      thumbNail: json['thumbnail'] as String?,
      productName: json['productName'] as String?,
      price: json['price'] as String?,
      hasSpecialPrice: json['hasSpecialPrice'] as bool?,
      specialPrice: json['specialPrice'] as String?,
    )..productId = json['productId'] as String?;

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'price': instance.price,
      'thumbnail': instance.thumbNail,
      'productId': instance.productId,
      'productName': instance.productName,
      'specialPrice': instance.specialPrice,
      'hasSpecialPrice': instance.hasSpecialPrice,
    };
