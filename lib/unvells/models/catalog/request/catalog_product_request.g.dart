// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalog_product_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CatalogProductRequest _$CatalogProductRequestFromJson(
        Map<String, dynamic> json) =>
    CatalogProductRequest(
      page: (json['page'] as num?)?.toInt(),
      id: json['id'] as String?,
      type: json['type'] as String?,
      sortData: (json['sortData'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      filterData: (json['filterData'] as List<dynamic>?)
          ?.map((e) => Map<String, String>.from(e as Map))
          .toList(),
      category_id: json['category_id'] as String?,
    );

Map<String, dynamic> _$CatalogProductRequestToJson(
        CatalogProductRequest instance) =>
    <String, dynamic>{
      'page': instance.page,
      'id': instance.id,
      'category_id': instance.category_id,
      'type': instance.type,
      'sortData': instance.sortData,
      'filterData': instance.filterData,
    };
