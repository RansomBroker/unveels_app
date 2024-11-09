// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'featured_categories.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeaturedCategories _$FeaturedCategoriesFromJson(Map<String, dynamic> json) =>
    FeaturedCategories(
      url: json['url'] as String?,
      dominantColor: json['dominantColor'] as String?,
      categoryName: json['categoryName'] as String?,
      categoryId: (json['categoryId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$FeaturedCategoriesToJson(FeaturedCategories instance) =>
    <String, dynamic>{
      'url': instance.url,
      'dominantColor': instance.dominantColor,
      'categoryName': instance.categoryName,
      'categoryId': instance.categoryId,
    };
