// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalog_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CatalogModel _$CatalogModelFromJson(Map<String, dynamic> json) => CatalogModel(
      productList: (json['productList'] as List<dynamic>?)
          ?.map((e) => ProductTileData.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: (json['totalCount'] as num?)?.toInt(),
      sortingData: (json['sortingData'] as List<dynamic>?)
          ?.map((e) => SortingData.fromJson(e as Map<String, dynamic>))
          .toList(),
      layeredData: (json['layeredData'] as List<dynamic>?)
          ?.map((e) => LayeredData.fromJson(e as Map<String, dynamic>))
          .toList(),
      banners: (json['banners'] as List<dynamic>?)
          ?.map((e) => Banners.fromJson(e as Map<String, dynamic>))
          .toList(),
      criteriaData: (json['criteriaData'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..otherError = json['otherError'] as String?
      ..redirect = json['redirect'] as String?
      ..eTag = json['eTag'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt()
      ..transferValidation = json['transferValidation'] as bool?;

Map<String, dynamic> _$CatalogModelToJson(CatalogModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otherError': instance.otherError,
      'redirect': instance.redirect,
      'eTag': instance.eTag,
      'cartCount': instance.cartCount,
      'transferValidation': instance.transferValidation,
      'productList': instance.productList,
      'totalCount': instance.totalCount,
      'sortingData': instance.sortingData,
      'layeredData': instance.layeredData,
      'banners': instance.banners,
      'criteriaData': instance.criteriaData,
    };
