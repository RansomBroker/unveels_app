// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LinkData _$LinkDataFromJson(Map<String, dynamic> json) => LinkData(
      json['id'] as String?,
      json['linkTitle'] as String?,
      json['price'] as String?,
      json['formattedPrice'] as String?,
      json['url'] as String?,
      json['fileName'] as String?,
      (json['haveLinkSample'] as num?)?.toInt(),
      json['linkSampleTitle'] as String?,
    );

Map<String, dynamic> _$LinkDataToJson(LinkData instance) => <String, dynamic>{
      'id': instance.id,
      'linkTitle': instance.linkTitle,
      'price': instance.price,
      'formattedPrice': instance.formattedPrice,
      'url': instance.url,
      'fileName': instance.fileName,
      'haveLinkSample': instance.haveLinkSample,
      'linkSampleTitle': instance.linkSampleTitle,
    };
