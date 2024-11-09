// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      (json['id'] as num?)?.toInt(),
      json['name'] as String?,
      json['thumbnail'] as String?,
      json['thumbnailDominantColor'] as String?,
      json['hasChildren'] as bool?,
      (json['childCategories'] as List<dynamic>?)
          ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['bannerImage'] as List<dynamic>?)
          ?.map((e) => BannerImages.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'thumbnail': instance.thumbnail,
      'thumbnailDominantColor': instance.thumbnailDominantColor,
      'hasChildren': instance.hasChildren,
      'childCategories': instance.childCategories,
      'bannerImage': instance.bannerImage,
    };
