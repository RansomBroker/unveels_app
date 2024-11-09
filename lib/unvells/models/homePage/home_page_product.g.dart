// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_page_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      productId: json['product_id'] as String?,
      thumb: json['thumb'] as String?,
      dominantColor: json['dominant_color'] as String?,
      name: json['name'] as String?,
      price: json['price'] as String?,
      quantity: json['quantity'] as String?,
      special: (json['special'] as num?)?.toInt(),
      formattedSpecial: json['formatted_special'] as String?,
      tax: json['tax'] as String?,
      rating: (json['rating'] as num?)?.toInt(),
      reviews: json['reviews'] as String?,
      hasOption: json['hasOption'] as bool?,
      wishlistStatus: json['wishlist_status'] as bool?,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'product_id': instance.productId,
      'thumb': instance.thumb,
      'dominant_color': instance.dominantColor,
      'name': instance.name,
      'price': instance.price,
      'quantity': instance.quantity,
      'special': instance.special,
      'formatted_special': instance.formattedSpecial,
      'tax': instance.tax,
      'rating': instance.rating,
      'reviews': instance.reviews,
      'hasOption': instance.hasOption,
      'wishlist_status': instance.wishlistStatus,
    };
